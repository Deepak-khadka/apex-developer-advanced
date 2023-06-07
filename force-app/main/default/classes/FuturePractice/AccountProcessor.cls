public with sharing class AccountProcessor {

    @future(callout=true)
    public static void countContacts(List<Id> accountIds) {

        /* 
         * toUpdateAccount An Empty Array List to update the Account.
         * accounts A List of Accounts with total number of Contacts.
        */
        List<Account> toUpdateAccount = new List<Account>();
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];

        // Looping through the Accounts and updating the Number of Contacts in Number_of_Contacts__c field.
        for(Account account : accounts) {
            Integer contactCount = account.Contacts.size();
            account.Number_of_Contacts__c = contactCount;
            toUpdateAccount.add(account);
        }

        // Updating the Accounts.
        update toUpdateAccount;
        
    }
}