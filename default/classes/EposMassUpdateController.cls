/**
 * @Description       : This class updates the specific EPOS records after accepting PDL flags and EPOS Ids 
 *                      from MassUpdateEpos LWC component.
 * @Coverage          : Test.cls | @CC100%
 * @Author            : Vicky Madankar
 * @Created Date      : 30-4-2024
 * @last modified by  : Vicky.Madankar@Perficient.com
 * Modifications Log
 * Ver   Date         Author                                    Modification
 * 1.0   04-30-2023   Vicky.Madankar@Perficient.com            Initial Version | Story Number | 
 **/


public with sharing class EposMassUpdateController {
    @AuraEnabled(cacheable=false)
    public static String updateEposRecords(String csvData, List<String> selectedCheckboxes) {   
        try {	
            List<String> recordIdsToUpdate = csvData.split(',');
     /** just for debugging
			System.debug(recordIdsToUpdate.size());
            for(String str : recordIdsToUpdate){
                System.debug(str);
            }
     **/

            List<EPOS__c> eposRecords = [SELECT Id,
			                                 HPS_Notification_Flag__c,
											 HPS_Notification_Type__c,
											 PDL30_Flag__c,
											 PDL40_Flag__c,
											 PDL50_Flag__c,
											 PDL60_Flag__c,
											 PDL70_Flag__c,
											 PDL80_Flag__c
											 FROM EPOS__c
											 WHERE Id 
											 IN :recordIdsToUpdate];
            system.debug('Records Retrived In Query '+eposRecords);
            
            for (EPOS__c record : eposRecords) {
                record.HPS_Notification_Flag__c = true;
                record.HPS_Notification_Type__c='Modify';
         
                for(String checkboxValue: selectedCheckboxes){
                    if(checkboxValue=='PDL_30'){
                        record.PDL30_Flag__c=true;
                        system.debug('30 CHECK '+checkboxValue);
                    }
                    else if(checkboxValue=='PDL_40'){
                        record.PDL40_Flag__c=true;
                        system.debug('40 CHECK '+checkboxValue);
                    } else if(checkboxValue=='PDL_50'){
                        record.PDL50_Flag__c=true;
                        system.debug('50 CHECK'+checkboxValue);
                    } else if(checkboxValue=='PDL_60'){
                        record.PDL60_Flag__c=true;
                        system.debug('60 CHECK'+checkboxValue);
                    }
					else if(checkboxValue=='PDL_70'){
                        record.PDL70_Flag__c=true;
                        system.debug('70 CHECK'+checkboxValue);
                    }
					else if(checkboxValue=='PDL_80'){
                        record.PDL80_Flag__c=true;
                        system.debug('80 CHECK'+checkboxValue);
                    }	
                }
            }
			
            update eposRecords;
            return 'Success';
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
}
