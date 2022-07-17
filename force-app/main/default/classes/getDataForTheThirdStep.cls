public with sharing class getDataForTheThirdStep {
    @AuraEnabled(cacheable= true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Account.Name, Name_Amount__c, (SELECT Opportunity.Id, Opportunity.Name, Opportunity.CreatedDate, Opportunity.CloseDate, Opportunity.StageName, Opportunity.Amount FROM Account.Opportunities WHERE Opportunity.StageName = 'Closed Won') FROM Account 
        WHERE Id IN (SELECT AccountId FROM Opportunity WHERE StageName = 'Closed Won')];
    }

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccount(String accId) {
        return [SELECT Id, Account.Name, (SELECT Opportunity.Id, Opportunity.Name, Opportunity.CreatedDate, Opportunity.CloseDate, Opportunity.StageName, Opportunity.Amount FROM Account.Opportunities WHERE Opportunity.StageName = 'Closed Won') FROM Account WHERE Id = :accId];
    }

    @AuraEnabled(cacheable = true)
    public static List<OpportunityLineItem> getOppProd(String oppId) {
        List<OpportunityLineItem> oppProdList = [SELECT Id, Product2.Name, Quantity, TotalPrice FROM OpportunityLineItem WHERE OpportunityId = :oppId];
        return oppProdList;
    }
}