resource "azurerm_resource_group" "rg" {
  name     = "${var.company}-${var.resource_group_name}-rg"
  location = var.location
}

resource "azurerm_storage_account" "blobstorage" {
  name                     = "${var.env}${var.storage_account_name}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.blob_storage_account_tier
  account_replication_type = var.blob_account_replication_type
#   allow_blob_public_access = true
}

resource "azurerm_storage_account" "functionstorage" {
  name                     = "${var.company}${var.env}${var.storage_account_name_function}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.function_storage_account_tier
  account_replication_type = var.function_account_replication_type
#   allow_blob_public_access = true
}

resource "azurerm_storage_container" "images_container" {
  name                  = var.images_container_name
  storage_account_name  = azurerm_storage_account.blobstorage.name
  container_access_type = var.images_container_access_type # "blob" "private"
}

resource "azurerm_storage_container" "thumbnail_container" {
  name                  = var.thumbnail_container_name
  storage_account_name  = azurerm_storage_account.blobstorage.name
  container_access_type = var.thumbnail_container_access_type # "blob" "private"
}

resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_windows_web_app" "webapp" {
  name                = var.image_resizer_webapp
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id = azurerm_service_plan.asp.id

   site_config {


       application_stack   {
         current_stack = "dotnet"
         dotnet_version = "v6.0"
       }
  }

  app_settings = {
    "AzureStorageConfig__ImageContainer" = "images" #var.image_container_azstorage_config
    "AzureStorageConfig__ThumbnailContainer" = "thumbnails" #var.thumbnail_container_azstorage_config
    "AzureStorageConfig__AccountName" = azurerm_storage_account.blobstorage.name
    "AzureStorageConfig__AccountKey" = azurerm_storage_account.blobstorage.primary_access_key
    "WEBSITE_NODE_DEFAULT_VERSION" = "~14" #var.website_node_default_version
  }

}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "example" {
  app_id   = azurerm_windows_web_app.webapp.id
  repo_url = var.webapp_repo_url
  branch   = var.webapp_repo_branch
  use_manual_integration = true
  use_mercurial      = false
}

# resource "null_resource" "webapp_deployment" {
#   provisioner "local-exec" {
#     command = "az webapp deployment source config --name ${azurerm_windows_web_app.webapp.name} --resource-group ${azurerm_resource_group.rg.name} --branch master --manual-integration --repo-url https://github.com/Azure-Samples/storage-blob-upload-from-webapp"
#   }
# }

############################ Second part of the project ############################################


resource "azurerm_windows_function_app" "functionapp" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.functionstorage.name
  storage_account_access_key = azurerm_storage_account.functionstorage.primary_access_key
  service_plan_id            = azurerm_service_plan.asp.id

  site_config {}

  app_settings = {
        THUMBNAIL_CONTAINER_NAME = "thumbnails"
        THUMBNAIL_WIDTH = "100"
        FUNCTIONS_WORKER_RUNTIME = "dotnet"
        FUNCTIONS_EXTENSION_VERSION = "~3"
        AzureWebJobsStorage = azurerm_storage_account.blobstorage.primary_connection_string

        
    }
 
}

# resource "azurerm_eventgrid_event_subscription" "example" {
#   name  = "example-aees"
#   scope = azurerm_resource_group.rg.id
#   azure_function_endpoint = azure_function_endpoint
#   event_delivery_schema = "EventGridSchema"
#   topic_name = "my-eventgrid-topic"

#   azure_function_endpoint {
#     function_id = "${azurerm_windows_function_app.example.id/functions/example}"
#   }

#   included_event_types = [
#     "Microsoft.Storage.BlobCreated"
#   ]

#   subject_filter {
#     subject_begins_with = "/blobServices/default/containers/images/"
#   }
# }

resource "null_resource" "functionapp_deployment" {
  provisioner "local-exec" {
    command = "az functionapp deployment source config --name ${azurerm_windows_function_app.functionapp.name} --resource-group ${azurerm_resource_group.rg.name} --branch master --manual-integration --repo-url https://github.com/Azure-Samples/function-image-upload-resize"
  }
}



resource "azurerm_function_app_function" "function" {
  name            = var.function_app_function
  function_app_id = azurerm_windows_function_app.functionapp.id
  language        = var.language
  test_data = jsonencode({
    "name" = "Azure"
  })
  config_json = jsonencode({
  # "generatedBy": "Microsoft.NET.Sdk.Functions-3.0.2",
  # "configurationSource": "attributes",
  # "bindings": [
  #   {
  #     "type": "eventGridTrigger",
  #     "name": "eventGridEvent"
  #   }
  # ],
  # "disabled": false,
  # "scriptFile": "../bin/ImageFunctions.dll",
  # "entryPoint": "ImageFunctions.Thumbnail.Run"

    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "eventGridEvent"
        "type" = "eventGridTrigger"
      }
    ]
  })
}

resource "azurerm_eventgrid_event_subscription" "subscription" {
  name                 = var.image_resizer_eventsub
  scope                = azurerm_storage_account.functionstorage.id
  included_event_types = ["Microsoft.Storage.BlobCreated", "Microsoft.Storage.BlobDeleted"]
  event_delivery_schema = var.event_delivery_schema
  
  azure_function_endpoint {
    function_id                       = azurerm_function_app_function.function.id
    max_events_per_batch              = 1
    preferred_batch_size_in_kilobytes = 64
  }
  subject_filter {
    subject_begins_with = "/blobServices/default/containers/images/"
    # subject_ends_with   = ".jpg"
  }
}

# resource "azurerm_eventgrid_system_topic" "example" {
#   name                   = "example-system-topic"
#   location               = "Global"
#   resource_group_name    = azurerm_resource_group.rg.name
#   source_arm_resource_id = azurerm_resource_group.rg.id
#   topic_type             = "Microsoft.Resources.ResourceGroups"
#   # system_topic           =  "imagestoragesystopic"
# }
