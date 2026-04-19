package com.pms;

import com.pms.util.PasswordUtil;
import org.junit.Test;
import static org.junit.Assert.*;

public class AppTest {

    @Test
    public void md5MatchesMySQLMD5() {
        // MySQL: SELECT MD5('admin123') = '0192023a7bbd73250516f069df18b500'
        assertEquals("0192023a7bbd73250516f069df18b500", PasswordUtil.md5("admin123"));
    }

    @Test
    public void md5AlwaysReturns32Chars() {
        assertEquals(32, PasswordUtil.md5("test").length());
        assertEquals(32, PasswordUtil.md5("").length());
    }
}
