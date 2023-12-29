@RestResource(urlMapping='/ContactMapping/*')
global class ContactAPI {
    
    @HttpPost
    global static Integer doPost() {
        
        try{
            system.debug(RestContext.request.requestBody.toString());
            String strBody = RestContext.request.requestBody.toString();
            List<ContactAPI.ConWrapper> wrp = (List<ContactAPI.ConWrapper>)JSON.deserialize(strBody, List<ContactAPI.ConWrapper>.class);
            
            List<Contact> conList = new List<Contact>();
            for(ConWrapper con : wrp){
                Contact conRec = new Contact();
                conRec.FirstName = con.firstName;
                conRec.LastName = con.lastName;
                conRec.Email = con.emailCon;            
                conList.add(conRec);
            }
            if(conList.size() > 0){
                insert conList;
                return conList.size();
            } 
            return -1;
        }catch(Exception e){
            return 0;
        }
    }
    
    @HttpGet
    global static List<String> geGet(){
        List<String> emailList = new List<String>();
        for(Contact con : [Select Email from Contact LIMIT 50000]){
            if(con.Email != null)emailList.add(String.valueOf(con.Email));
        }
        return emailList;
    }
    
    public class ConWrapper{
        public String firstName{get;Set;}
        public String lastName{get;Set;}
        public String emailCon{get;Set;}
    }
}