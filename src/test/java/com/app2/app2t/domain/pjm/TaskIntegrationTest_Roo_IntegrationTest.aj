// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.pjm;

import com.app2.app2t.domain.pjm.Task;
import com.app2.app2t.domain.pjm.TaskDataOnDemand;
import com.app2.app2t.domain.pjm.TaskIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect TaskIntegrationTest_Roo_IntegrationTest {
    
    declare @type: TaskIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: TaskIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: TaskIntegrationTest: @Transactional;
    
    @Autowired
    TaskDataOnDemand TaskIntegrationTest.dod;
    
    @Test
    public void TaskIntegrationTest.testCountTasks() {
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", dod.getRandomTask());
        long count = Task.countTasks();
        Assert.assertTrue("Counter for 'Task' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void TaskIntegrationTest.testFindTask() {
        Task obj = dod.getRandomTask();
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Task' failed to provide an identifier", id);
        obj = Task.findTask(id);
        Assert.assertNotNull("Find method for 'Task' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Task' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void TaskIntegrationTest.testFindAllTasks() {
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", dod.getRandomTask());
        long count = Task.countTasks();
        Assert.assertTrue("Too expensive to perform a find all test for 'Task', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Task> result = Task.findAllTasks();
        Assert.assertNotNull("Find all method for 'Task' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Task' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void TaskIntegrationTest.testFindTaskEntries() {
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", dod.getRandomTask());
        long count = Task.countTasks();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Task> result = Task.findTaskEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Task' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Task' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void TaskIntegrationTest.testFlush() {
        Task obj = dod.getRandomTask();
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Task' failed to provide an identifier", id);
        obj = Task.findTask(id);
        Assert.assertNotNull("Find method for 'Task' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyTask(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'Task' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void TaskIntegrationTest.testMergeUpdate() {
        Task obj = dod.getRandomTask();
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Task' failed to provide an identifier", id);
        obj = Task.findTask(id);
        boolean modified =  dod.modifyTask(obj);
        Integer currentVersion = obj.getVersion();
        Task merged = (Task)obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Task' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void TaskIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", dod.getRandomTask());
        Task obj = dod.getNewTransientTask(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Task' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Task' identifier to be null", obj.getId());
        try {
            obj.persist();
        } catch (final ConstraintViolationException e) {
            final StringBuilder msg = new StringBuilder();
            for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                final ConstraintViolation<?> cv = iter.next();
                msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
            }
            throw new IllegalStateException(msg.toString(), e);
        }
        obj.flush();
        Assert.assertNotNull("Expected 'Task' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void TaskIntegrationTest.testRemove() {
        Task obj = dod.getRandomTask();
        Assert.assertNotNull("Data on demand for 'Task' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Task' failed to provide an identifier", id);
        obj = Task.findTask(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'Task' with identifier '" + id + "'", Task.findTask(id));
    }
    
}
