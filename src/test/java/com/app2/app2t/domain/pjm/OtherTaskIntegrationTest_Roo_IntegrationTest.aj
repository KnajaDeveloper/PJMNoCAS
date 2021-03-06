// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.pjm;

import com.app2.app2t.domain.pjm.OtherTask;
import com.app2.app2t.domain.pjm.OtherTaskDataOnDemand;
import com.app2.app2t.domain.pjm.OtherTaskIntegrationTest;
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

privileged aspect OtherTaskIntegrationTest_Roo_IntegrationTest {
    
    declare @type: OtherTaskIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: OtherTaskIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: OtherTaskIntegrationTest: @Transactional;
    
    @Autowired
    OtherTaskDataOnDemand OtherTaskIntegrationTest.dod;
    
    @Test
    public void OtherTaskIntegrationTest.testCountOtherTasks() {
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", dod.getRandomOtherTask());
        long count = OtherTask.countOtherTasks();
        Assert.assertTrue("Counter for 'OtherTask' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void OtherTaskIntegrationTest.testFindOtherTask() {
        OtherTask obj = dod.getRandomOtherTask();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to provide an identifier", id);
        obj = OtherTask.findOtherTask(id);
        Assert.assertNotNull("Find method for 'OtherTask' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'OtherTask' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void OtherTaskIntegrationTest.testFindAllOtherTasks() {
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", dod.getRandomOtherTask());
        long count = OtherTask.countOtherTasks();
        Assert.assertTrue("Too expensive to perform a find all test for 'OtherTask', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<OtherTask> result = OtherTask.findAllOtherTasks();
        Assert.assertNotNull("Find all method for 'OtherTask' illegally returned null", result);
        Assert.assertTrue("Find all method for 'OtherTask' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void OtherTaskIntegrationTest.testFindOtherTaskEntries() {
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", dod.getRandomOtherTask());
        long count = OtherTask.countOtherTasks();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<OtherTask> result = OtherTask.findOtherTaskEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'OtherTask' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'OtherTask' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void OtherTaskIntegrationTest.testFlush() {
        OtherTask obj = dod.getRandomOtherTask();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to provide an identifier", id);
        obj = OtherTask.findOtherTask(id);
        Assert.assertNotNull("Find method for 'OtherTask' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyOtherTask(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'OtherTask' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void OtherTaskIntegrationTest.testMergeUpdate() {
        OtherTask obj = dod.getRandomOtherTask();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to provide an identifier", id);
        obj = OtherTask.findOtherTask(id);
        boolean modified =  dod.modifyOtherTask(obj);
        Integer currentVersion = obj.getVersion();
        OtherTask merged = (OtherTask)obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'OtherTask' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void OtherTaskIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", dod.getRandomOtherTask());
        OtherTask obj = dod.getNewTransientOtherTask(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'OtherTask' identifier to be null", obj.getId());
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
        Assert.assertNotNull("Expected 'OtherTask' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void OtherTaskIntegrationTest.testRemove() {
        OtherTask obj = dod.getRandomOtherTask();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'OtherTask' failed to provide an identifier", id);
        obj = OtherTask.findOtherTask(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'OtherTask' with identifier '" + id + "'", OtherTask.findOtherTask(id));
    }
    
}
