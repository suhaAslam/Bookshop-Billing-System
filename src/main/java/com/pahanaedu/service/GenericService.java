package com.pahanaedu.service;

import com.pahanaedu.dao.GenericDAO;
import java.util.List;

public class GenericService<T> {

    private final GenericDAO<T> dao;

    public GenericService(GenericDAO<T> dao) {
        this.dao = dao;
    }

    public boolean addEntity(T entity) {
        return dao.add(entity);
    }

    public T getEntityById(int id) {
        return dao.getById(id);
    }

    public List<T> getAllEntities() {
        return dao.getAll();
    }

    public boolean updateEntity(T entity) {
        return dao.update(entity);
    }

    public boolean deleteEntity(int id) {
        return dao.delete(id);
    }
}
