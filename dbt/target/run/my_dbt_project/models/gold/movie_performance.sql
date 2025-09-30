-- back compat for old kwarg name
  
  
  
      
          
          
      
  

  

  merge into `workspace`.`movielens_volume`.`movie_performance` as DBT_INTERNAL_DEST
      using `movie_performance__dbt_tmp` as DBT_INTERNAL_SOURCE
      on 
              DBT_INTERNAL_SOURCE.movie_id = DBT_INTERNAL_DEST.movie_id
          

      when matched then update set
         * 

      when not matched then insert *
