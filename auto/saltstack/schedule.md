Scheduling can be enabled by multiple methods:
  
1. schedule option in either the master or minion config files. These require the master or minion application to be restarted in order for the schedule to be implemented.  
2. Minion pillar data. Schedule is implemented by refreshing the minion's pillar data, for example by using saltutil.refresh_pillar.  
3. The schedule state or schedule module  

