# TASK-101: 用户注册接口

【基础信息】
状态：TODO
负责人：pmo
优先级：HIGH

【需求描述】
实现用户注册 RESTful API，支持邮箱和手机号注册，需持久化至用户表。

【输入依赖文件】
- docs/prd.md (产品需求文档)
- docs/architecture.md (系统架构设计)
- docs/api-spec.md (接口规范)
- docs/database.md (用户表 DDL)

【验收标准】
1. 密码必须经过 BCRYPT 哈希加密存储，严禁明文
2. 邮箱/手机号重复注册需返回 409 Conflict
3. 必填字段校验失败返回 400 Bad Request
4. QA 单元测试覆盖率 > 85%
5. 包含边界值测试：超长用户名、空密码、特殊字符邮箱

【调度路由】
pm -> architect -> dba -> backend-dev -> reviewer -> qa-engineer -> memory -> report

【流转记录】
- [2026-06-21] pmo 创建任务 -> TODO
