# TASK-102: 安全依赖审计与修复

【基础信息】
状态：TODO
负责人：pmo
优先级：MEDIUM

【需求描述】
审计项目第三方依赖中已知的 CVE 漏洞，修复高危风险并输出审计报告。

【输入依赖文件】
- docs/architecture.md (技术栈与依赖清单)

【验收标准】
1. 识别所有直接和传递依赖中的已知 CVE（严重/高危）
2. 修复方案需包含版本升级或替代库建议
3. 修复后需通过全部现有单元测试
4. 输出审计报告至 reports/security-audit.md

【调度路由】
research -> security -> cyber -> reviewer -> qa-engineer -> memory -> report

【安全路由说明】
- research: 调研 CVE 详情与影响范围
- security: 输出只读审计报告（edit: deny）
- cyber: 仅在 security 发现可复现漏洞时介入，输出修复代码
- reviewer: 二次审查修复代码合规性

【流转记录】
- [2026-06-21] pmo 创建任务 -> TODO
