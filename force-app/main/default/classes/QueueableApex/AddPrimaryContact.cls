public class AddPrimaryContact implements Queueable{
    
    private Contact contact;
    private String stateAbbreviation;

    public AddPrimaryContact(Contact contact, String stateAbbreviation){
     this.contact = contact;
     this.stateAbbreviation = stateAbbreviation;
    }

    public void execute(QueueableContext context){
        List<Account> accounts = [SELECT Id, Name, 
        (SELECT Id, FirstName, LastName FROM Contacts) 
        FROM Account WHERE BillingState = :stateAbbreviation LIMIT 200];

        List<Contact> contacts = new List<Contact>();

        for(Account account : accounts){
            Contact con = contact.clone(false, false, false, false);
            con.AccountId = account.Id;
            contacts.add(con);
        }

        if(!contacts.isEmpty()){
            insert contacts;
        }
    }
}