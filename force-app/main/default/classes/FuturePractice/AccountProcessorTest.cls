@isTest
private class AccountProcessorTest {
   
    @isTest
    static void testAccountProcessor() {
        // Create test data
        List<Account> accounts = new List<Account>();
        List<Id> accountIds = new List<Id>();

        for (Integer i = 0; i < 200; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
        
        for(Account account : accounts) {
            accountIds.add(account.Id);
        }
        
        // Call the method to test
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        
        // Verify the results
        List<Account> updatedAccounts = [SELECT Id, Name, Number_of_Contacts__c FROM Account];
        System.assertEquals(200, updatedAccounts.size(), 'Size of Account should be 200');

        for (Account account : updatedAccounts) {
            System.assertEquals(0, account.Number_of_Contacts__c, 'Number of contact count is 0');
        }
    }
}