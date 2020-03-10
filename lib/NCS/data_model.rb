# NCS module extension point
module NCS
  # Data model module
  module DataModel

    ItemModel = JSON.parse(<<~ITEM_MODEL
      {
             "Id": 2,
             "ProductCategoryName": "Buds",
             "Name": "Buds Item",
             "UnitOfMeasureName": "Ounces",
             "AdministrationMethod": null,
             "StrainName": "Spring Hill Kush",
             "IntermediaryProductUsed": false,
             "UnitCbdPercent": null,
             "UnitCbdContent": null,
             "UnitCbdContentUnitOfMeasureName": null,
             "UnitThcPercent": null,
             "UnitThcContent": null,
             "UnitThcContentUnitOfMeasureName": null,
             "UnitVolume": null,
             "UnitVolumeUnitOfMeasureName": null,
             "UnitWeight": null,
             "UnitWeightUnitOfMeasureName": null,
             "ServingSize": null,
             "SupplyDurationDays": null,
             "Ingredients": null,
             "Intermediaries": [
                  {
                      "Id": 1,
                      "Name": "Interm 1",
                      "Type": "Mush"
                  },
                  {
                      "Name": "Interm 2",
                      "Type": "Tar"
                  }
              ]
          }
    ITEM_MODEL
    )
    ItemCategoryModel = JSON.parse(<<~ITEM_CATEGORY_MODEL
      {
        "Name": "Infused",
        "ProductCategoryType": "InfusedEdible",
        "QuantityType": "CountBased",
        "DefaultLabTestingState": "NotSubmitted",
        "RequiresApproval": false,
        "RequiresAdministrationMethod": false,
        "RequiresStrain": true,
        "RequiresUnitCbdPercent": false,
        "RequiresUnitCbdContent": false,
        "RequiresUnitThcPercent": false,
        "RequiresUnitThcContent": false,
        "RequiresUnitVolume": false,
        "RequiresUnitWeight": false,
        "RequiresServingSize": false,
        "RequiresSupplyDurationDays": false,
        "UnitQuantityMultiplier": null,
        "UnitQuantityUnitOfMeasureName": null,
        "RequiresIngredients": false,
        "RequiresProductPhoto": false,
        "CanContainSeeds": true,
        "CanBeRemediated": true
      }
    ITEM_CATEGORY_MODEL
    )
    RoomModel = JSON.parse(<<~ROOM_MODEL
      {
          "id": 0,
          "locationId": 0,
          "organizationId": 0,
          "vendorId": 0,
          "name": "string",
          "createDate": "2020-03-09T18:15:13.028Z",
          "updateDate": "2020-03-09T18:15:13.028Z"
      }
    ROOM_MODEL
    )

    PlantPackageModel = JSON.parse(<<~PLANT_PACKAGE_MODEL
      {
          "id": 0,
          "locationId": 0,
          "organizationId": 0,
          "vendorId": 0,
          "label": "string",
          "sourceHarvestNames": "string",
          "roomId": 0,
          "roomName": "string",
          "quantity": 0,
          "initialQuantity": 0,
          "unitOfMeasureName": "string",
          "unitOfMeasureAbbreviation": "string",
          "productId": 0,
          "productName": "string",
          "productCategoryName": "string",
          "packagedDate": "2020-03-09T18:56:16.248Z",
          "initialLabTestingState": "string",
          "labTestingState": "string",
          "labTestingStateDate": "2020-03-09T18:56:16.248Z",
          "isProductionBatch": true,
          "productionBatchNumber": "string",
          "isTestingSample": true,
          "isProcessValidationTestingSample": true,
          "productRequiresRemediation": true,
          "containsRemediatedProduct": true,
          "remediationMethodId": 0,
          "remediationMethodName": "string",
          "remediationSteps": "string",
          "remediationDate": "2020-03-09T18:56:16.248Z",
          "receivedFromManifestNumber": 0,
          "receivedFromFacilityLicenseNumber": 0,
          "receivedFromFacilityName": "string",
          "receivedDateTime": "2020-03-09T18:56:16.248Z",
          "isOnHold": true,
          "archivedDate": "2020-03-09T18:56:16.248Z",
          "finishedDate": "2020-03-09T18:56:16.248Z",
          "adjustmentReason": "string",
          "adjustmentDate": "2020-03-09T18:56:16.248Z",
          "adjustmentNote": "string",
          "plantBatchId": 0,
          "plantBatchName": "string",
          "lastModified": "2020-03-09T18:56:16.248Z",
          "createDate": "2020-03-09T18:56:16.248Z",
          "updateDate": "2020-03-09T18:56:16.248Z",
          "harvestId": 0,
          "weight": 0,
          "plantCount": 0,
          "plantBatchTypeName": "string",
          "strainName": "string",
          "plantedDate": "2020-03-09T18:56:16.248Z",
          "ingredients": [
            {
              "id": 0,
              "label": "string",
              "quantity": 0,
              "unitOfMeasureName": "string",
              "packageId": 0
            }
          ]
        }
    PLANT_PACKAGE_MODEL
    )

    PlantBatchModel = JSON.parse(<<~PLANT_BATCH_MODEL
      {
          "id": 0,
          "locationId": 0,
          "organizationId": 0,
          "vendorId": 0,
          "name": "string",
          "type": "string",
          "roomId": 0,
          "roomName": "string",
          "strainId": 0,
          "strainName": "string",
          "count": 0,
          "liveCount": 0,
          "packagedCount": 0,
          "harvestedCount": 0,
          "destroyedCount": 0,
          "sourcePackageId": 0,
          "sourcePackageLabel": "string",
          "sourcePlantId": 0,
          "sourcePlantLabel": "string",
          "plantedDate": "2020-03-09T18:55:31.295Z",
          "lastModified": "2020-03-09T18:55:31.295Z",
          "createDate": "2020-03-09T18:55:31.295Z",
          "updateDate": "2020-03-09T18:55:31.295Z",
          "growthDate": "2020-03-09T18:55:31.295Z",
          "growthPhase": "string",
          "newTag": "string",
          "destroyedDate": "2020-03-09T18:55:31.295Z",
          "destroyedNote": "string",
          "posPlants": [
            {
              "id": 0,
              "locationId": 0,
              "organizationId": 0,
              "vendorId": 0,
              "label": "string",
              "state": "string",
              "growthPhase": "string",
              "plantBatchId": 0,
              "plantBatchName": "string",
              "plantBatchTypeName": "string",
              "strainId": 0,
              "strainName": "string",
              "roomId": 0,
              "roomName": "string",
              "harvestId": 0,
              "harvestedUnitOfWeightName": "string",
              "harvestedUnitOfWeightAbbreviation": "string",
              "harvestedWetWeight": 0,
              "manicuredUnitOfWeightName": "string",
              "manicuredWeight": 0,
              "manicuredDate": "2020-03-09T18:55:31.295Z",
              "harvestCount": 0,
              "isOnHold": true,
              "plantedDate": "2020-03-09T18:55:31.295Z",
              "vegetativeDate": "2020-03-09T18:55:31.295Z",
              "floweringDate": "2020-03-09T18:55:31.295Z",
              "harvestedDate": "2020-03-09T18:55:31.295Z",
              "destroyedDate": "2020-03-09T18:55:31.295Z",
              "destroyedNote": "string",
              "destroyedByUserName": "string",
              "lastModified": "2020-03-09T18:55:31.295Z",
              "createDate": "2020-03-09T18:55:31.295Z",
              "updateDate": "2020-03-09T18:55:31.295Z",
              "plantCount": 0,
              "newTag": "string",
              "growthDate": "2020-03-09T18:55:31.295Z",
              "newRoom": "string",
              "harvestName": "string"
            }
          ]
        }
    PLANT_BATCH_MODEL
    )

    def extract_keys(model)
      model.keys
    end
  end
end
