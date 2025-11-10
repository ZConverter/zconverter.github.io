---
layout: page
title: ZDM API Documentation (English)
---

# ZDM API RESTful Documentation

## Table of Contents

1. [Overview](#overview)
2. [Authentication](#authentication)
3. [Standard API Response Format](#standard-api-response-format)
4. [Authentication Endpoints](#authentication-endpoints)
   - [POST /auth/issue](#post-authissue) - Issue Token
5. [User Management](#user-management)
   - [GET /users](#get-users) - Get User List
   - [GET /users/:identifier](#get-usersidentifier) - Get Specific User
   - [PUT /users/:identifier](#put-usersidentifier) - Update User Information
6. [Server Management](#server-management)
   - [GET /servers](#get-servers) - Get Server List
   - [GET /servers/:identifier](#get-serversidentifier) - Get Specific Server
   - [GET /servers/:identifier/partitions](#get-serversidentifierpartitions) - Get Server Partitions
   - [GET /servers/partitions](#get-serverspartitions) - Get All Partitions
7. [Schedule Management](#schedule-management)
   - [GET /schedules](#get-schedules) - Get Schedule List
   - [GET /schedules/:identifier](#get-schedulesidentifier) - Get Specific Schedule
   - [POST /schedules](#post-schedules) - Create Schedule
8. [Backup Management](#backup-management)
   - [GET /backups](#get-backups) - Get Backup List
   - [GET /backups/:identifier](#get-backupsidentifier) - Get Specific Backup
   - [POST /backups](#post-backups) - Register Backup Job
   - [PUT /backups/:identifier](#put-backupsidentifier) - Update Backup Job
   - [DELETE /backups/:identifier](#delete-backupsidentifier) - Delete Backup Job
   - [GET /backups/monitoring/job/:identifier](#get-backupsmonitoringjobidentifier) - Monitor Backup Job
   - [GET /backups/monitoring/system/:identifier](#get-backupsmonitoringsystemidentifier) - Monitor System Backup
9. [Recovery Management](#recovery-management)
   - [GET /recoveries](#get-recoveries) - Get Recovery List
   - [GET /recoveries/:identifier](#get-recoveriesidentifier) - Get Specific Recovery
   - [POST /recoveries](#post-recoveries) - Register Recovery Job
   - [PUT /recoveries/:identifier](#put-recoveriesidentifier) - Update Recovery Job
   - [DELETE /recoveries/:identifier](#delete-recoveriesidentifier) - Delete Recovery Job
   - [GET /recoveries/monitoring/job/:identifier](#get-recoveriesmonitoringjobidentifier) - Monitor Recovery Job
   - [GET /recoveries/monitoring/system/:identifier](#get-recoveriesmonitoringsystemidentifier) - Monitor System Recovery
10. [File Management](#file-management)
    - [POST /files/upload](#post-filesupload) - Upload File
    - [GET /files/list](#get-fileslist) - Get Uploaded File List
    - [GET /files/download/:fileName](#get-filesdownloadfilename) - Download File
11. [License Management](#license-management)
    - [GET /licenses](#get-licenses) - Get License List
    - [GET /licenses/:identifier](#get-licensesidentifier) - Get Specific License
    - [GET /licenses/key/:key](#get-licenseskeykey) - Get License by Key
    - [POST /licenses](#post-licenses) - Register License
    - [PUT /licenses/assign](#put-licensesassign) - Assign License
12. [ZDM Center Management](#zdm-center-management)
    - [GET /zdms](#get-zdms) - Get ZDM Center List
    - [GET /zdms/:identifier](#get-zdmsidentifier) - Get Specific ZDM Center
    - [GET /zdms/:identifier/repositories](#get-zdmsidentifierrepositories) - Get ZDM Center Repositories
    - [GET /zdms/repositories](#get-zdmsrepositories) - Get All ZDM Repositories
13. [Common Patterns](#common-patterns)
14. [API Endpoints Summary](#api-endpoints-summary)

## Overview
ZDM-API is a REST API server for backup, recovery, and system management. It is based on token authentication and follows domain-driven design architecture.

**Base URL**: `/api/v1`

## Authentication
All protected endpoints require a token:
```
Authorization: Bearer <token>
```

## Standard API Response Format
All API responses follow the standard format below:

**Success Response:**
```json
{
  "success": true,
  "requestID": "string",
  "data": {},
  "message": "string",
  "timestamp": "string",
  "meta": {}
}
```

**Error Response:**
```json
{
  "success": false,
  "requestID": "string",
  "error": "string",
  "timestamp": "string",
  "detail": {}
}
```

**Pagination Response:**
```json
{
  "success": true,
  "requestID": "string",
  "data": [],
  "message": "string",
  "timestamp": "string",
  "meta": {
    "currentPage": 1,
    "totalPages": 10,
    "totalItems": 100,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  }
}
```

---

## Authentication Endpoints

### POST `/auth/issue`
Issues a token.

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Required | User email |
| password | string | Required | User password |

**Response:**
```json
{
  "success": true,
  "requestID": "req-123",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "expiresAt": "2024-12-31T23:59:59.000Z"
  },
  "message": "Token issued successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Status Codes:**
- `201` - Token issued successfully
- `400` - Invalid request data
- `401` - Authentication failed

---

## User Management

### GET `/users`
Retrieves the user list.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | Filter by username |
| position | string | Optional | Filter by position |
| company | string | Optional | Filter by company |
| country | string | Optional | Filter by country |

**Response:**
```json
{
  "success": true,
  "requestID": "req-456",
  "data": [
    {
      "id": "1",
      "email": "user@example.com",
      "userName": "John Doe",
      "company": "ZDM Corp",
      "country": "US",
      "position": "Developer"
    }
  ],
  "message": "User list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/users/:identifier`
Retrieves specific user information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | User ID or email |

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| userName | string | Optional | Filter by username |
| position | string | Optional | Filter by position |
| company | string | Optional | Filter by company |
| country | string | Optional | Filter by country |

**Response:**
```json
{
  "success": true,
  "requestID": "req-789",
  "data": {
    "id": "1",
    "email": "user@example.com",
    "userName": "John Doe",
    "company": "ZDM Corp",
    "country": "US",
    "position": "Developer"
  },
  "message": "User information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### PUT `/users/:identifier`
Updates user information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | User ID or email |

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| userName | string | Optional | Username |
| password | string | Optional | Password |
| pwData | string | Optional | Password data |
| position | string | Optional | Position |
| company | string | Optional | Company name |
| country | string | Optional | Country code (2 characters, e.g., KR, US) |

**Response:**
```json
{
  "success": true,
  "requestID": "req-user-update",
  "data": {
    "userInfo": {
      "id": "1",
      "email": "user@example.com",
      "userName": "John Doe",
      "company": "ZDM Corp",
      "country": "US",
      "position": "Senior Developer"
    },
    "summary": {
      "state": "success",
      "message": "User information updated successfully",
      "updatedFieldsCount": 1,
      "updatedFields": [
        {
          "field": "Position",
          "previous": "Developer",
          "new": "Senior Developer"
        }
      ]
    }
  },
  "message": "User information updated successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Features:**
- Change history tracking: Tracks previous and new values for each modified field
- Security field masking: password and pwData fields are displayed as `********` in responses
- Partial updates: Only provided fields are updated

**Status Codes:**
- `200` - Update successful
- `400` - Invalid request data
- `404` - User not found
- `500` - Server error

---

## Server Management

### GET `/servers`
Retrieves the server list.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| mode | string | Optional | System mode (source, target) |
| os | string | Optional | Operating system type (linux, windows) |
| connection | string | Optional | Connection status (online, offline) |
| license | string | Optional | License assignment status |
| network | boolean | Optional | Include network information |
| disk | boolean | Optional | Include disk information |
| partition | boolean | Optional | Include partition information |
| repository | boolean | Optional | Include repository information |
| detail | boolean | Optional | Include detailed information |

**Response:**
```json
{
  "success": true,
  "requestID": "req-server-list",
  "data": [
    {
      "id": "1",
      "name": "web-server-01",
      "agent": {
        "mode": "source",
        "version": "1.0.0"
      },
      "os": {
        "version": "Ubuntu 20.04"
      },
      "ip": {
        "public": "192.168.1.100",
        "private": ["10.0.0.100"]
      },
      "license": {
        "id": "LICENSE-001"
      },
      "status": {
        "connect": "online"
      },
      "disk": [],
      "network": [],
      "partition": [],
      "repository": [],
      "lastUpdated": "2024-01-31T10:30:45.123Z"
    }
  ],
  "message": "Server list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/servers/:identifier`
Retrieves specific server information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Server ID or server name |

**Query Parameters:** (Same as GET `/servers`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-server-detail",
  "data": {
    "id": "1",
    "name": "web-server-01",
    "agent": {
      "mode": "source",
      "version": "1.0.0"
    },
    "os": {
      "version": "Ubuntu 20.04"
    },
    "ip": {
      "public": "192.168.1.100",
      "private": ["10.0.0.100"]
    },
    "license": {
      "id": "LICENSE-001"
    },
    "status": {
      "connect": "online"
    },
    "lastUpdated": "2024-01-31T10:30:45.123Z"
  },
  "message": "Server information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/servers/:identifier/partitions`
Retrieves partition information for a specific server.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Server ID or server name |

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| detail | boolean | Optional | Include detailed information |

### GET `/servers/partitions`
Retrieves partition information for all servers.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| serverName | string | Optional | Filter by server name |
| detail | boolean | Optional | Include detailed information |

---

## Schedule Management

### GET `/schedules`
Retrieves the schedule list.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | string | Optional | Filter by schedule ID |
| type | string | Optional | Filter by schedule type |
| state | string | Optional | Filter by active state |
| jobName | string | Optional | Filter by job name |

**Response:**
```json
{
  "success": true,
  "requestID": "req-schedule-list",
  "data": [
    {
      "id": "1",
      "center": {
        "id": "CENTER-001",
        "name": "Main Center"
      },
      "type": "backup",
      "state": "active",
      "jobName": "daily-backup-job",
      "lastRunTime": "2024-01-31T02:00:00.000Z",
      "description": "Daily backup schedule"
    }
  ],
  "message": "Schedule list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/schedules/:identifier`
Retrieves specific schedule information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Schedule ID or job name |

**Query Parameters:** (Same as GET `/schedules`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-schedule-detail",
  "data": {
    "id": "1",
    "center": {
      "id": "CENTER-001",
      "name": "Main Center"
    },
    "type": "backup",
    "state": "active",
    "jobName": "daily-backup-job",
    "lastRunTime": "2024-01-31T02:00:00.000Z",
    "description": "Daily backup schedule"
  },
  "message": "Schedule information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### POST `/schedules`
Creates a new schedule.

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| center | string | Required | Center ID or name |
| user | string | Required | User ID or email |
| jobName | string | Required | Job name |
| type | number | Required | Schedule type (1: Smart, 2: Common) |
| basic | object | Required | Basic schedule settings |
| basic.type | string | Required | Basic schedule type |
| basic.description | string | Required | Basic schedule description |
| advanced | object | Optional | Advanced schedule settings |
| advanced.type | string | Optional | Advanced schedule type |
| advanced.description | string | Optional | Advanced schedule description |

**Response:**
```json
{
  "success": true,
  "requestID": "req-schedule-create",
  "data": {
    "id": "2",
    "center": {
      "id": "CENTER-001",
      "name": "Main Center"
    },
    "type": "backup",
    "state": "active",
    "jobName": "new-backup-job",
    "schedule": {
      "basic": "0 2 * * *",
      "advanced": "daily at 2:00 AM"
    }
  },
  "message": "Schedule created successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

---

## Backup Management

### GET `/backups`
Retrieves the backup job list.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| mode | string | Optional | Filter by backup mode |
| partition | string | Optional | Filter by partition |
| status | string | Optional | Filter by job status |
| repositoryID | string | Optional | Filter by repository ID |
| repositoryType | string | Optional | Filter by repository type |
| repositoryPath | string | Optional | Filter by repository path |
| serverName | string | Optional | Filter by server name |
| serverType | string | Optional | Filter by server type |
| detail | boolean | Optional | Include detailed information |
| active | boolean | Optional | Show only active jobs |
| history | boolean | Optional | Include history |
| logs | boolean | Optional | Include logs |

**Response:**
```json
{
  "success": true,
  "requestID": "req-backup-list",
  "data": [
    {
      "system": {
        "id": "SRV-001",
        "name": "web-server-01",
        "os": "Ubuntu 20.04"
      },
      "job": {
        "info": {
          "id": "JOB-001",
          "name": "daily-backup-web",
          "mode": "full",
          "partition": "/dev/sda1",
          "schedule": {
            "basic": "0 2 * * *",
            "advanced": "daily at 2:00 AM"
          },
          "status": {
            "current": "completed",
            "time": {
              "start": "2024-01-31T02:00:00.000Z",
              "elapsed": "45m 30s",
              "end": "2024-01-31T02:45:30.000Z"
            }
          }
        },
        "lastUpdated": "2024-01-31T02:45:30.000Z"
      },
      "repository": {
        "id": "REPO-001",
        "type": "local",
        "path": "/backup/storage"
      }
    }
  ],
  "message": "Backup job list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/backups/:identifier`
Retrieves specific backup job information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Backup job ID or job name |

**Query Parameters:** (Same as GET `/backups`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-backup-detail",
  "data": {
    "system": {
      "id": "SRV-001",
      "name": "web-server-01",
      "os": "Ubuntu 20.04"
    },
    "job": {
      "info": {
        "id": "JOB-001",
        "name": "daily-backup-web",
        "mode": "full",
        "partition": "/dev/sda1",
        "schedule": {
          "basic": "0 2 * * *",
          "advanced": "daily at 2:00 AM"
        },
        "status": {
          "current": "completed",
          "time": {
            "start": "2024-01-31T02:00:00.000Z",
            "elapsed": "45m 30s",
            "end": "2024-01-31T02:45:30.000Z"
          }
        }
      },
      "lastUpdated": "2024-01-31T02:45:30.000Z"
    },
    "repository": {
      "id": "REPO-001",
      "type": "local",
      "path": "/backup/storage"
    }
  },
  "message": "Backup job information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### POST `/backups`
Registers a new backup job.

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| center | string | Required | Center ID or name |
| server | string | Required | Server ID or name |
| type | string | Required | Backup type |
| partition | array | Required | Partitions to backup |
| repository | object | Required | Repository information |
| repository.id | number | Required | Repository ID |
| repository.type | string | Required | Repository type |
| repository.path | string | Required | Repository path |
| jobName | string | Required | Job name |
| user | string | Required | User ID or email |
| schedule | object | Required | Schedule information |
| schedule.type | string | Required | Schedule type |
| schedule.description | string | Required | Schedule description |
| description | string | Optional | Job description |
| rotation | number | Optional | Retention period |
| compression | string | Optional | Compression settings |
| encryption | string | Optional | Encryption settings |
| excludeDir | array | Optional | Directories to exclude |
| excludePartition | array | Optional | Partitions to exclude |
| mailEvent | string | Optional | Email notification settings |
| networkLimit | number | Optional | Network limit |
| autoStart | string | Optional | Auto-start option |

**Response:**
```json
{
  "success": true,
  "requestID": "req-backup-register",
  "data": {
    "results": [
      {
        "state": "success",
        "jobName": "daily-backup-web",
        "partition": "/dev/sda1",
        "jobMode": "full",
        "autoStart": "yes",
        "schedule": {
          "basic": "0 2 * * *",
          "advanced": "daily at 2:00 AM"
        },
        "errorMessage": null
      }
    ],
    "summary": {
      "total": 1,
      "successful": 1,
      "failed": 0
    }
  },
  "message": "Backup job registered successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### PUT `/backups/:identifier`
Updates a backup job.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Backup job ID or job name |

**Request Body:** (Same as POST `/backups`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-backup-update",
  "data": {
    "jobName": "updated-backup-job",
    "status": "updated"
  },
  "message": "Backup job updated successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### DELETE `/backups/:identifier`
Deletes a backup job.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Backup job ID or job name |

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| force | boolean | Optional | Force delete |

**Response:**
```json
{
  "success": true,
  "requestID": "req-backup-delete",
  "data": {
    "deletedJobName": "daily-backup-web",
    "deletedAt": "2024-01-31T10:30:45.123Z"
  },
  "message": "Backup job deleted successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/backups/monitoring/job/:identifier`
Retrieves monitoring information for a specific backup job.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Backup job ID or job name |

**Response:**
```json
{
  "success": true,
  "requestID": "req-backup-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "job": {
      "info": {
        "name": "daily-backup-web",
        "partition": "/dev/sda1",
        "drive": "C:"
      },
      "progressInfo": {
        "status": "PROCESSING",
        "percent": "75",
        "message": "Backing up system files",
        "start": "2024-01-31T02:00:00.000Z",
        "elapsed": "30m 15s",
        "end": null
      },
      "log": [
        "2024-01-31 02:00:00 - Backup started",
        "2024-01-31 02:15:00 - Processing system files",
        "2024-01-31 02:30:00 - 75% completed"
      ]
    }
  },
  "message": "Backup monitoring information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/backups/monitoring/system/:identifier`
Retrieves backup monitoring information for a specific system.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | System ID or system name |

**Response:**
```json
{
  "success": true,
  "requestID": "req-system-backup-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "jobs": [
      {
        "name": "daily-backup-web",
        "status": "PROCESSING",
        "progress": "75%",
        "startTime": "2024-01-31T02:00:00.000Z"
      }
    ]
  },
  "message": "System backup monitoring information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

---

## Recovery Management

### GET `/recoveries`
Retrieves the recovery job list.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| status | string | Optional | Filter by job status |
| platform | string | Optional | Filter by platform type |
| mode | string | Optional | Filter by recovery mode |
| partition | string | Optional | Filter by partition |
| drive | string | Optional | Filter by drive |
| backupName | string | Optional | Filter by backup name |
| repositoryID | string | Optional | Filter by repository ID |
| repositoryType | string | Optional | Filter by repository type |
| repositoryPath | string | Optional | Filter by repository path |
| detail | boolean | Optional | Include detailed information |
| server | string | Optional | Filter by server name |
| serverType | string | Optional | Filter by server type |

**Response:**
```json
{
  "success": true,
  "requestID": "req-recovery-list",
  "data": [
    {
      "system": {
        "source": {
          "id": "SRV-001",
          "name": "web-server-01",
          "os": "Ubuntu 20.04"
        },
        "target": {
          "id": "SRV-002",
          "name": "backup-server-01",
          "os": "Ubuntu 20.04"
        }
      },
      "job": {
        "info": {
          "id": "REC-001",
          "name": "system-recovery-job",
          "schedule": {
            "basic": "0 3 * * 0"
          },
          "status": {
            "current": "completed",
            "time": {
              "start": "2024-01-31T03:00:00.000Z",
              "elapsed": "2h 15m",
              "end": "2024-01-31T05:15:00.000Z"
            }
          },
          "lastUpdated": "2024-01-31T05:15:00.000Z"
        },
        "detail": []
      }
    }
  ],
  "message": "Recovery job list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/recoveries/:identifier`
Retrieves specific recovery job information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Recovery job ID or job name |

**Query Parameters:** (Same as GET `/recoveries`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-recovery-detail",
  "data": {
    "system": {
      "source": {
        "id": "SRV-001",
        "name": "web-server-01",
        "os": "Ubuntu 20.04"
      },
      "target": {
        "id": "SRV-002",
        "name": "backup-server-01",
        "os": "Ubuntu 20.04"
      }
    },
    "job": {
      "info": {
        "id": "REC-001",
        "name": "system-recovery-job",
        "schedule": {
          "basic": "0 3 * * 0"
        },
        "status": {
          "current": "completed",
          "time": {
            "start": "2024-01-31T03:00:00.000Z",
            "elapsed": "2h 15m",
            "end": "2024-01-31T05:15:00.000Z"
          }
        },
        "lastUpdated": "2024-01-31T05:15:00.000Z"
      },
      "detail": []
    }
  },
  "message": "Recovery job information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### POST `/recoveries`
Registers a new recovery job.

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| center | string | Required | Center ID or name |
| source | string | Required | Source server ID or name |
| target | string | Required | Target server ID or name |
| platform | string | Required | Platform type |
| repository | object | Required | Repository information |
| repository.id | number | Required | Repository ID |
| repository.type | string | Required | Repository type |
| repository.path | string | Required | Repository path |
| mode | string | Required | Recovery mode |
| jobName | string | Required | Job name |
| overwrite | string | Required | Overwrite option |
| user | string | Required | User ID or email |
| schedule | object | Required | Schedule information |
| schedule.type | string | Required | Schedule type |
| schedule.description | string | Required | Schedule description |
| description | string | Optional | Job description |
| afterReboot | string | Optional | Action after reboot |
| networkLimit | number | Optional | Network limit |
| excludePartition | array | Optional | Partitions to exclude |
| mailEvent | string | Optional | Email notification settings |
| autoStart | string | Optional | Auto-start option |
| scriptPath | string | Optional | Script path |
| scriptRun | string | Optional | Script execution option |
| cloudAuth | number | Optional | Cloud authentication ID |
| listOnly | boolean | Optional | List only mode |
| jobList | array | Optional | Job list |
| jobList[].sourcePartition | string | Required | Source partition |
| jobList[].targetPartition | string | Required | Target partition |
| jobList[].overwrite | string | Required | Overwrite option |
| jobList[].isOverwrite | boolean | Required | Overwrite flag |
| jobList[].backupFile | string | Required | Backup file name |
| jobList[].mode | string | Required | Recovery mode |
| jobList[].repository | object | Required | Repository information |

**Response:**
```json
{
  "success": true,
  "requestID": "req-recovery-register",
  "data": {
    "jobName": "system-recovery-job",
    "jobId": "REC-002",
    "schedule": {
      "basic": "0 3 * * 0",
      "advanced": "weekly on Sunday at 3:00 AM"
    },
    "status": "registered"
  },
  "message": "Recovery job registered successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### PUT `/recoveries/:identifier`
Updates a recovery job.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Recovery job ID or job name |

**Request Body:** (Same as POST `/recoveries`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-recovery-update",
  "data": {
    "jobName": "updated-recovery-job",
    "status": "updated"
  },
  "message": "Recovery job updated successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### DELETE `/recoveries/:identifier`
Deletes a recovery job.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Recovery job ID or job name |

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| force | boolean | Optional | Force delete |

**Response:**
```json
{
  "success": true,
  "requestID": "req-recovery-delete",
  "data": {
    "jobInfo": [
      {
        "name": "system-recovery-job",
        "partition": "/, /test/, /de",
        "deletedComponents": {
          "basicInfo": true,
          "additionalInfo": true,
          "detailInfo": true,
          "historyData": true,
          "logData": true
        },
        "errorMessage": null
      }
    ],
    "summary": {
      "state": "success",
      "affectedComponents": {
        "basicInfoDeleted": 1,
        "additionalInfoDeleted": 1,
        "detailInfoDeleted": 2,
        "historyDataDeleted": 5,
        "logDataDeleted": 3
      }
    }
  },
  "message": "Recovery job deleted successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Response Fields:**
- `jobInfo`: Array of deleted job information
  - `name`: Job name
  - `partition`: Related partition list (comma-separated, e.g., "/, /test/, /de")
  - `deletedComponents`: Deleted component status
    - `basicInfo`: Basic information deletion status
    - `additionalInfo`: Additional information deletion status
    - `detailInfo`: Detail information deletion status
    - `historyData`: History data deletion status
    - `logData`: Log data deletion status
  - `errorMessage`: Error message (only on failure)
- `summary`: Deletion summary information
  - `state`: Overall job status ("success" | "fail")
  - `affectedComponents`: Actual deleted record counts
    - `basicInfoDeleted`: Number of basic info records deleted (typically 1)
    - `additionalInfoDeleted`: Number of additional info records deleted (typically 1)
    - `detailInfoDeleted`: Number of detail info records deleted (can be as many as partition count)
    - `historyDataDeleted`: Number of history records deleted
    - `logDataDeleted`: Number of log records deleted

**Status Codes:**
- `200` - Delete successful
- `400` - Invalid request
- `404` - Job not found
- `500` - Server error

### GET `/recoveries/monitoring/job/:identifier`
Retrieves monitoring information for a specific recovery job.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | Recovery job ID or job name |

**Response:**
```json
{
  "success": true,
  "requestID": "req-recovery-monitoring",
  "data": {
    "system": {
      "source": "web-server-01",
      "target": "backup-server-01"
    },
    "job": {
      "info": {
        "name": "system-recovery-job",
        "mode": "full",
        "partition": "/dev/sda1"
      },
      "progressInfo": {
        "status": "PROCESSING",
        "percent": "60",
        "message": "Restoring system files",
        "start": "2024-01-31T03:00:00.000Z",
        "elapsed": "1h 30m",
        "end": null
      },
      "log": [
        "2024-01-31 03:00:00 - Recovery started",
        "2024-01-31 03:30:00 - Restoring partition data",
        "2024-01-31 04:30:00 - 60% completed"
      ]
    }
  },
  "message": "Recovery monitoring information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/recoveries/monitoring/system/:identifier`
Retrieves recovery monitoring information for a specific system.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | System ID or system name |

**Response:**
```json
{
  "success": true,
  "requestID": "req-system-recovery-monitoring",
  "data": {
    "system": {
      "name": "web-server-01"
    },
    "jobs": [
      {
        "name": "system-recovery-job",
        "status": "PROCESSING",
        "progress": "60%",
        "startTime": "2024-01-31T03:00:00.000Z"
      }
    ]
  },
  "message": "System recovery monitoring information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

---

## File Management

### POST `/files/upload`
Uploads a file.

**Request:** Multipart form data
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| file | file | Required | File to upload |

**Response:**
```json
{
  "success": true,
  "requestID": "req-file-upload",
  "data": {
    "file": {
      "originalName": "document.pdf",
      "fileName": "20240131_103045_document.pdf",
      "path": "/uploads/2024/01/31/20240131_103045_document.pdf",
      "size": 1048576,
      "mimeType": "application/pdf",
      "uploadedAt": "2024-01-31T10:30:45.123Z"
    }
  },
  "message": "File uploaded successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Features:**
- Multipart form data format for file transmission
- Maximum file size: 10MB
- Maximum file count: 5 files
- Korean filename support
- Unique filename generation (timestamp + random number)

**Status Codes:**
- `201` - Upload successful
- `400` - Invalid request (file size exceeded, file count exceeded, etc.)
- `500` - Server error

### GET `/files/download/:fileName`
Downloads a file.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| fileName | string | Required | File name to download |

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| download | boolean | Optional | Force download mode |
| preview | boolean | Optional | Preview mode |
| range | string | Optional | Partial download range (bytes=0-1023) |

**Response:** File stream or error response

**On Success:** File is downloaded directly.

**On Failure (File not found):**
```json
{
  "success": false,
  "requestID": "req-file-download",
  "error": "FILE_NOT_FOUND",
  "timestamp": "2024-01-31T10:30:45.123Z",
  "detail": {
    "fileName": "nonexistent.pdf",
    "message": "The requested file could not be found"
  }
}
```

**Features:**
- Filename delivery via Content-Disposition header
- Korean filename support (UTF-8 encoding)
- Automatic MIME type detection

**Status Codes:**
- `200` - Download successful
- `404` - File not found
- `500` - Server error

### GET `/files/list`
Retrieves the list of uploaded files.

**Response:**
```json
{
  "success": true,
  "requestID": "req-file-list",
  "data": {
    "files": [
      {
        "fileName": "file-1706688645123-987654321-document.pdf",
        "fileOriginName": "document.pdf",
        "size": "1.5 MB",
        "uploadDate": "2024-01-31 10:30:45"
      },
      {
        "fileName": "file-1706602245456-123456789-report.xlsx",
        "fileOriginName": "report.xlsx",
        "size": "512.3 KB",
        "uploadDate": "2024-01-30 14:15:22"
      }
    ],
    "totalCount": 2
  },
  "message": "File list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Response Fields:**
- `fileName`: Actual filename stored on server (includes timestamp)
- `fileOriginName`: Original filename
- `size`: File size (converted to MB/KB units)
- `uploadDate`: Upload timestamp
- `totalCount`: Total file count

**Status Codes:**
- `200` - Retrieval successful
- `500` - Server error

---

## License Management

### GET `/licenses`
Retrieves the license list.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| category | string | Optional | Filter by license category |
| exp | string | Optional | Filter by expiration date (YYYY-MM-DD) |
| created | string | Optional | Filter by creation date (YYYY-MM-DD) |
| status | string | Optional | Filter by status (active, expired, expiring) |

**Response:**
```json
{
  "success": true,
  "requestID": "req-license-list",
  "data": [
    {
      "name": "ZDM Enterprise License",
      "key": "ZDME-2024-ABCD-1234-EFGH",
      "category": "enterprise",
      "copies": {
        "total": 100,
        "used": 75,
        "available": 25,
        "usage": "75%"
      },
      "description": "Enterprise backup solution license",
      "dates": {
        "created": "2024-01-01T00:00:00.000Z",
        "expires": "2024-12-31T23:59:59.000Z",
        "daysRemaining": 334
      }
    }
  ],
  "message": "License list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/licenses/:identifier`
Retrieves specific license information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | License ID or name |

**Query Parameters:** (Same as GET `/licenses`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-license-detail",
  "data": {
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "copies": {
      "total": 100,
      "used": 75,
      "available": 25,
      "usage": "75%"
    },
    "description": "Enterprise backup solution license",
    "dates": {
      "created": "2024-01-01T00:00:00.000Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    },
    "assignedServers": [
      {
        "serverId": "SRV-001",
        "serverName": "web-server-01",
        "assignedAt": "2024-01-15T10:00:00.000Z"
      }
    ]
  },
  "message": "License information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/licenses/key/:key`
Retrieves license information by key.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| key | string | Required | License key |

**Response:**
```json
{
  "success": true,
  "requestID": "req-license-by-key",
  "data": {
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "isValid": true,
    "status": "active",
    "copies": {
      "total": 100,
      "used": 75,
      "available": 25,
      "usage": "75%"
    },
    "dates": {
      "created": "2024-01-01T00:00:00.000Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    }
  },
  "message": "License key information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### POST `/licenses`
Registers a new license.

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| name | string | Required | License name |
| licenseKey | string | Required | License key |
| category | string | Required | License category |
| copies | number | Required | Total number of licenses |
| expirationDate | string | Required | Expiration date (YYYY-MM-DD) |
| description | string | Optional | Description |

**Response:**
```json
{
  "success": true,
  "requestID": "req-license-register",
  "data": {
    "id": "2",
    "name": "ZDM Enterprise License",
    "key": "ZDME-2024-ABCD-1234-EFGH",
    "category": "enterprise",
    "copies": {
      "total": 100,
      "used": 0,
      "available": 100,
      "usage": "0%"
    },
    "description": "Enterprise backup solution license",
    "dates": {
      "created": "2024-01-31T10:30:45.123Z",
      "expires": "2024-12-31T23:59:59.000Z",
      "daysRemaining": 334
    }
  },
  "message": "License registered successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Status Codes:**
- `201` - Registration successful
- `400` - Invalid request data (invalid license key, duplicate, etc.)
- `409` - License key conflict
- `500` - Server error

### PUT `/licenses/assign`
Assigns a license to a server.

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| licenseKey | string | Required | License key |
| serverId | string | Required | Server ID or server name |

**Response:**
```json
{
  "success": true,
  "requestID": "req-license-assign",
  "data": {
    "license": {
      "name": "ZDM Enterprise License",
      "key": "ZDME-2024-ABCD-1234-EFGH",
      "category": "enterprise"
    },
    "server": {
      "id": "1",
      "name": "web-server-01"
    },
    "assignment": {
      "assignedAt": "2024-01-31T10:30:45.123Z",
      "status": "active"
    },
    "usage": {
      "total": 100,
      "used": 76,
      "available": 24,
      "percentage": "76%"
    }
  },
  "message": "License assigned successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

**Status Codes:**
- `200` - Assignment successful
- `400` - Invalid request data
- `404` - License or server not found
- `409` - License already assigned or insufficient available licenses
- `500` - Server error

---

## ZDM Center Management

### GET `/zdms`
Retrieves the ZDM center list.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| connection | string | Optional | Filter by connection status (online, offline) |
| activation | string | Optional | Filter by activation status (active, inactive) |
| network | boolean | Optional | Include network information |
| disk | boolean | Optional | Include disk information |
| partition | boolean | Optional | Include partition information |
| repository | boolean | Optional | Include repository information |
| zosRepository | boolean | Optional | Include zOS repository information |
| detail | boolean | Optional | Include detailed information |

**Response:**
```json
{
  "success": true,
  "requestID": "req-zdm-list",
  "data": [
    {
      "name": {
        "center": "Main-ZDM-Center",
        "host": "zdm-center-01"
      },
      "id": {
        "center": "ZDM-001",
        "install": "INSTALL-2024-001"
      },
      "os": {
        "version": "Windows Server 2019"
      },
      "ip": {
        "public": "192.168.1.10",
        "private": ["10.0.0.10", "172.16.0.10"]
      },
      "status": {
        "connect": "online",
        "activate": "active"
      },
      "path": {
        "logFile": "C:\\ZDM\\logs\\zdm.log",
        "install": "C:\\ZDM"
      },
      "disk": [],
      "partition": [],
      "drive": [],
      "network": [],
      "repository": [],
      "zosRepository": [],
      "lastUpdated": "2024-01-31T10:30:45.123Z"
    }
  ],
  "message": "ZDM center list retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/zdms/:identifier`
Retrieves specific ZDM center information.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | ZDM center ID or center name |

**Query Parameters:** (Same as GET `/zdms`)

**Response:**
```json
{
  "success": true,
  "requestID": "req-zdm-detail",
  "data": {
    "name": {
      "center": "Main-ZDM-Center",
      "host": "zdm-center-01"
    },
    "id": {
      "center": "ZDM-001",
      "install": "INSTALL-2024-001"
    },
    "os": {
      "version": "Windows Server 2019"
    },
    "ip": {
      "public": "192.168.1.10",
      "private": ["10.0.0.10", "172.16.0.10"]
    },
    "status": {
      "connect": "online",
      "activate": "active"
    },
    "path": {
      "logFile": "C:\\ZDM\\logs\\zdm.log",
      "install": "C:\\ZDM"
    },
    "lastUpdated": "2024-01-31T10:30:45.123Z"
  },
  "message": "ZDM center information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/zdms/:identifier/repositories`
Retrieves repository information for a specific ZDM center.

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string | Required | ZDM center ID or center name |

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| type | string | Optional | Filter by repository type |
| path | string | Optional | Filter by path |
| status | string | Optional | Filter by status |

**Response:**
```json
{
  "success": true,
  "requestID": "req-zdm-repositories",
  "data": [
    {
      "id": "REPO-001",
      "name": "Primary Repository",
      "type": "local",
      "path": "C:\\ZDM\\Repository",
      "status": "online",
      "capacity": {
        "total": "1TB",
        "used": "256GB",
        "available": "768GB",
        "usage": "25%"
      }
    }
  ],
  "message": "ZDM center repository information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

### GET `/zdms/repositories`
Retrieves all ZDM repository information.

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| centerName | string | Optional | Filter by center name |
| type | string | Optional | Filter by repository type |
| path | string | Optional | Filter by path |
| status | string | Optional | Filter by status |

**Response:**
```json
{
  "success": true,
  "requestID": "req-all-repositories",
  "data": [
    {
      "center": {
        "id": "ZDM-001",
        "name": "Main-ZDM-Center"
      },
      "repository": {
        "id": "REPO-001",
        "name": "Primary Repository",
        "type": "local",
        "path": "C:\\ZDM\\Repository",
        "status": "online",
        "capacity": {
          "total": "1TB",
          "used": "256GB",
          "available": "768GB",
          "usage": "25%"
        }
      }
    }
  ],
  "message": "All ZDM repository information retrieved successfully",
  "timestamp": "2024-01-31T10:30:45.123Z"
}
```

---

## Common Patterns

### Error Response Format
All error responses follow this format:
```json
{
  "error": {
    "code": "string",
    "message": "string",
    "details": {}
  }
}
```

### Status Codes
- `200` - Success
- `201` - Created successfully
- `400` - Invalid request
- `401` - Authentication failed
- `403` - Insufficient permissions
- `404` - Resource not found
- `409` - Conflict
- `500` - Server error

### Identifier Pattern
Most endpoints support flexible identifier interpretation:
- **Numeric value**: Processed as ID
- **String value**: Processed as Name/Email, etc.

### Pagination
List retrieval endpoints support standard pagination:
```json
{
  "data": [],
  "pagination": {
    "page": "number",
    "limit": "number",
    "total": "number",
    "totalPages": "number"
  }
}
```