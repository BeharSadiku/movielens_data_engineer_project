-- back compat for old kwarg name
  
  
  
      
          
          
      
  

  

  merge into `workspace`.`movielens_volume`.`user_activity` as DBT_INTERNAL_DEST
      using `user_activity__dbt_tmp` as DBT_INTERNAL_SOURCE
      on 
              DBT_INTERNAL_SOURCE.user_id = DBT_INTERNAL_DEST.user_id
          

      when matched then update set
         * 

      when not matched then insert *
