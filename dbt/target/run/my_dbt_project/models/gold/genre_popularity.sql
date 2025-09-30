-- back compat for old kwarg name
  
  
  
      
          
          
      
  

  

  merge into `workspace`.`movielens_volume`.`genre_popularity` as DBT_INTERNAL_DEST
      using `genre_popularity__dbt_tmp` as DBT_INTERNAL_SOURCE
      on 
              DBT_INTERNAL_SOURCE.genres = DBT_INTERNAL_DEST.genres
          

      when matched then update set
         * 

      when not matched then insert *
