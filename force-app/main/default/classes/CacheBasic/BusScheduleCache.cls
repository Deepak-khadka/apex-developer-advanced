public class BusScheduleCache {

    private Cache.OrgPartition part;
    
    public BusScheduleCache() {
        this.part = Cache.Org.getPartition('local.BusScheduleCache');
    }

    public void putSchedule(String busLine, Time[] schedule) {
       Cache.Org.put(busLine, schedule); 
    }

    public static Time[] getSchedule(String busLine) {
        Time[] sch = (Time[])Cache.Org.get(busLine);
        Time[] schedule = new List<Time>();

        if(sch != null) {
            return sch;
        }
        else {
            Time t1 = Time.newInstance(8, 0, 0, 0);
            Time t2 = Time.newInstance(17, 0, 0, 0);
            schedule.add(t1);
            schedule.add(t2);
            return schedule;
        }
        
    }
}