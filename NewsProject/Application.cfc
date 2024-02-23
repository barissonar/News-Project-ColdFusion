component {

    this.datasource = "NewsProjectDB";
    this.ormEnabled = true;
    this.ormSettings = { logsql : true, dbcreate = 'update' };
    this.invokeImplicitAccessor = false;
    function onApplicationStart() {
       
        setLocale("tr_TR");
        

   

        return true;
    }




}