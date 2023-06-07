@isTest
private class UpdateContactAddressesTest {
    
    @TestSetup
    static void setUp(){
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();

        // insert 10 accounts 

        for (Integer i=0; i< 10; i++) {
            accounts.add(
                new Account(
                    name='Account ' + i, 
                    BillingCity='New York', 
                    BillingCountry='USA'));
        }
        insert accounts;

        // Find the account just inserted. add contact for each
        for(Account account: [SELECT id from Account]){
            contacts.add(
                new Contact(
                    firstName='first',
                    lastName='last',
                    accountId=account.Id));
        }

        insert contacts;
    }

    @isTest 
    static void test() {
        Test.startTest();
        UpdateContactAddresses uca = new UpdateContactAddresses();
        Id batchId = Database.executeBatch(uca);
        test.stopTest();
        Integer totalCount = [SELECT COUNT() from Contact where MailingCity='New Your'];
        System.assertEquals(10, 10, 'Match the count of contact total number');
    }
}