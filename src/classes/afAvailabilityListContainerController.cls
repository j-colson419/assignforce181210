public class afAvailabilityListContainerController {
    
    public static List<Training_Room__c> allRooms = [SELECT Id, name, TrainingLocationName__c, AVAvailability__c, RoomCapacity__c
                                                     FROM Training_Room__c
                                                     ORDER BY name];
    
    @AuraEnabled
    public static List<Training_Room__c> getRooms(){
        List<Training_Room__c> yesFirst = new List<Training_Room__c>();
        List<Training_Room__c> Requests = new List<Training_Room__c>();
        List<Training_Room__c> NOs = new List<Training_Room__c>();
        
        for(Training_Room__c room : allRooms){
            if(room.AVAvailability__c == 'Yes'){
                yesFirst.add(room);
            }else if(room.AVAvailability__c == 'Upon Request'){
                Requests.add(room);
            }else if(room.AVAvailability__c == 'No'){
                NOs.add(room);
            }
        }
        
        yesFirst.addAll(Requests);
        yesFirst.addAll(NOs);
        
        return yesFirst;
    }
    
    public static List<User> Trainers = [SELECT Id, Name, Available__c, Training_Skills__c From User OrderByName /*WHERE Available__c!=null*/ /*UserRoleId=trainer role Id*/];
    @AuraEnabled
    public static List<User> getAllTrainers(){
        //Must add a WHERE clause UserRoleId=Trainer Role Id
        List<User> availableList = new List<User>();
        List<User> unavailableList = new List<User>();
        for(User t: Trainers){
            if(t.Available__c=='Available'){
                availableList.add(t);
            }else{
                unavailableList.add(t);
            }
        }
        availableList.addAll(unavailableList);
        system.debug(availableList);
        return availableList;
    }
}