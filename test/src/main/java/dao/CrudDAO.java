package dao;

import java.util.List;

public interface CrudDAO <Entity, ID>{
    List<Entity> findAll();

    Entity findById (ID id);

    List<Entity> findBySql (String sql, Object... value);

    
}
