package com.polycoffee.dao;

import java.sql.ResultSet;

import com.polycoffee.util.JdbcUtil;

public class UserSecurityDAO {
    private static volatile boolean schemaReady = false;

    public boolean isTwoFactorEnabled(int userId) {
        ensureSchema();
        String sql = "SELECT twoFactorEnabled FROM USER_SECURITY WHERE userId = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, userId);
            if (rs.next()) {
                return rs.getBoolean("twoFactorEnabled");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int setTwoFactorEnabled(int userId, boolean enabled) {
        ensureSchema();
        String sql = """
                MERGE USER_SECURITY AS target
                USING (SELECT ? AS userId) AS source
                ON target.userId = source.userId
                WHEN MATCHED THEN
                    UPDATE SET twoFactorEnabled = ?, updatedAt = SYSDATETIME()
                WHEN NOT MATCHED THEN
                    INSERT (userId, twoFactorEnabled, updatedAt)
                    VALUES (?, ?, SYSDATETIME());
                """;
        try {
            return JdbcUtil.executeUpdate(sql, userId, enabled, userId, enabled);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private void ensureSchema() {
        if (schemaReady) {
            return;
        }
        synchronized (UserSecurityDAO.class) {
            if (schemaReady) {
                return;
            }
            String sql = """
                    IF OBJECT_ID(N'USER_SECURITY', N'U') IS NULL
                    BEGIN
                        CREATE TABLE USER_SECURITY (
                            userId INT NOT NULL PRIMARY KEY,
                            twoFactorEnabled BIT NOT NULL DEFAULT 0,
                            updatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
                            CONSTRAINT FK_USER_SECURITY_USER FOREIGN KEY (userId)
                                REFERENCES NHANVIEN(MaNV)
                        );
                    END
                    """;
            try {
                JdbcUtil.executeUpdate(sql);
                schemaReady = true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
