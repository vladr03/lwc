public inherited sharing class Search {
    @AuraEnabled(Cacheable = true)
    public static List<Account> findAccounts(String accName) {
        accName = '%' + accName + '%';
        List<Account> accList = [SELECT Id, Name, Name_Amount__c, (SELECT Opportunity.Name, Opportunity.CreatedDate, Opportunity.CloseDate, Opportunity.StageName, Opportunity.Amount FROM Account.Opportunities WHERE Opportunity.StageName = 'Closed Won') FROM Account 
        WHERE Name_Amount__c LIKE :accName AND Id IN (SELECT AccountId FROM Opportunity WHERE StageName = 'Closed Won') ORDER BY Amount_Won__c];
        return accList;
    }
}