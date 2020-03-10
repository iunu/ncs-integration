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

    def extract_keys(model)
      model.keys
    end
  end
end
