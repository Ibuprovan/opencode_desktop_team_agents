# Opencode Multi-Agent Virtual Engineering Team V2.3

## 概述

本仓库为 [opencode](https://opencode.ai) 提供一套多 Agent 虚拟工程团队配置，包含 14 个专业化 Agent，覆盖管理层、架构层、数据库层、研发层、质量红线层、安全层和基础设施层，实现从需求输入到交付报告的全闭环自动化开发。

V2.3 起，这套配置额外强化了真实编排能力：PMO 不再默认接管所有请求，而是在你显式触发团队工作流时，负责用真实 subagent 委派加文件写盘的方式推进协作，避免在单一上下文中口头模拟多角色协作。

## 快速开始

### 全局安装（推荐）

将配置复制到全局 opencode 配置目录：

```bash
# Windows
copy opencode.json %USERPROFILE%\.config\opencode\opencode.json
xcopy /E /Y .opencode\agents\*.md %USERPROFILE%\.config\opencode\agents\

# Linux / macOS
cp opencode.json ~/.config/opencode/opencode.json
cp -r .opencode/agents/*.md ~/.config/opencode/agents/
```

### 项目级安装

将 `opencode.json` 和 `.opencode/agents/` 放置到项目根目录即可。项目级配置会覆盖全局配置。

### 重启要求

修改 `opencode.json` 或 `.opencode/agents/*.md` 后，必须完全重启 opencode，运行中的会话不会热加载这些配置。

## 团队架构

```
┌─────────────────────────────────────────────────────────────┐
│                    管理层 & 架构层                            │
│         pmo ──> pm ──> architect ──> dba                    │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                    研发层（并行）                              │
│              backend-dev ∥ frontend-dev                      │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                    质量红线层                                 │
│         reviewer ──> qa-engineer                            │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                    基础设施层                                 │
│              memory ──> report                              │
└─────────────────────────────────────────────────────────────┘
```

## Agent 一览

| 层级 | Agent | 职责 | 输出 |
|------|-------|------|------|
| 管理层 | `pmo` | 项目管理办公室：接收需求、评估复杂度、拆解任务、监控死循环 | `docs/project-plan.md` |
| 管理层 | `pm` | 产品经理：需求分析、用户场景设计、编写 PRD | `docs/prd.md` |
| 架构层 | `architect` | 系统架构师：技术选型、微服务划分、全局接口规范、技术仲裁 | `docs/architecture.md`, `docs/api-spec.md` |
| 数据库层 | `dba` | 数据库工程师：物理建模、索引优化、安全与扩展规范 | `docs/database.md` |
| 研发层 | `backend-dev` | 后端工程师：业务逻辑实现，严格遵循 DBA 表结构 | `src/` |
| 研发层 | `frontend-dev` | 前端工程师：页面 UI、状态管理、接口对接 | `frontend/` |
| 质量层 | `reviewer` | 代码审查员：架构合规性审查、代码规范检查 | `docs/review-report.md` |
| 质量层 | `qa-engineer` | 测试工程师：断言矩阵设计、自动化测试、质量红线卡点 | `docs/test-plan.md`, `docs/test-report.md` |
| 安全层 | `security` | 合规安全官：OWASP 风险评估、权限检查、阻断高危代码 | `docs/security-report.md` |
| 安全层 | `cyber` | 网安特化智能体：静态代码审计、漏洞 PoC 验证、渗透测试分析 | `reports/vulnerability-assessment.md` |
| 安全层 | `research` | 前沿调研员：CVE 漏洞调研、论文分析、技术攻关报告 | `docs/research.md` |
| 基础设施层 | `memory` | 记忆管理器：维护项目长期记忆、动态切片注入上下文 | `project-memory.md` |
| 基础设施层 | `report` | 报告生成器：实验报告、项目总结、学术格式文档整理 | `reports/` |
| 基础设施层 | `devops` | 交付工程师：Dockerfile、CI/CD、部署配置 | `deployment/` |

## 工作流

### 团队入口

默认仍然是普通 `build` 模式，适合小改动、一次性修复、轻量实现。

只有在你显式触发团队工作流时，PMO 才会接管并分发任务。这适合：

- 新需求、迭代优化、跨角色任务
- Debug、根因分析、回归修复
- 架构调整、重构、技术仲裁

显式触发入口命令：

- `/workflow`：完整工作流
- `/debug-workflow`：缺陷与排障工作流
- `/re-arch`：架构调整工作流

### 任务状态机

```
[TODO] ──> [IN_PROGRESS] ──> [REVIEWS] ──> [TESTING] ──> [DONE]
               ▲                │            │
               │                ▼            ▼
               └─────────── [REJECTED] <─────┘
                                │ (往返 > 3 次)
                                ▼
                            [BLOCKED] (PMO 仲裁)
```

### 六阶段工作流

**阶段 1：需求与架构基线**

`User` -> `pmo` -> `pm` (`prd.md`) -> `architect` (`architecture.md`, `api-spec.md`)

**阶段 2：数据建模（DBA 严控）**

`architect` -> `dba` (`database.md`)

**阶段 3：并行研发（分支隔离）**

`dba` -> `backend-dev` ∥ `frontend-dev`

**阶段 4：代码与架构双重审查**

开发完成 -> `reviewer` (`review-report.md`)

**阶段 5：动态测试硬门禁（QA 严控）**

`TESTING` -> `qa-engineer` (`test-plan.md`, `test-report.md`)

**阶段 6：记忆固化与交付**

`DONE` -> `memory` (`project-memory.md`) -> `report` (`reports/`)

## 三条铁律

1. **DBA 优先权**：后端代码含 `CREATE TABLE` 或 `ALTER TABLE` 且未在 `docs/database.md` 备案，`reviewer` 和 `qa-engineer` 必须直接否决。
2. **拒绝盲目断言**：测试用例必须覆盖 `try-catch`、错误处理、HTTP 非 200 状态码，否则视为无效。
3. **文件唯一性**：Agent 间禁止内存传代码，必须写盘后由下游文件读取承接。
4. **真实委派**：PMO 只有在实际发起 subagent 调用并收到结果后，才能声称某个角色已处理任务。

## 为什么你之前会遇到“假装调度”

旧版本主要有三个结构性问题：

1. PMO 虽然被定义为 subagent，但没有被赋予明确的 `task` 编排职责和强制调度协议，因此更像一个文档角色，而不是实际调度器。
2. 仓库有工作流说明，但缺少 `docs/tasks/` 运行时模板和明确的文件总线规则，导致 agent 之间没有稳定的写盘交接面。
3. Debug 和架构调整没有专门入口，所以这些请求很容易退化成单 agent 的普通问答，而不是团队协作。

## 目录结构

```
.
├── opencode.json                  # Agent 配置（权限、模型、描述）
├── agents.md                      # V2.2 完整工作流文档
├── .opencode/
│   └── agents/                    # Agent 指令文件
│       ├── pmo.md
│       ├── pm.md
│       ├── architect.md
│       ├── dba.md
│       ├── backend-dev.md
│       ├── frontend-dev.md
│       ├── reviewer.md
│       ├── qa-engineer.md
│       ├── security.md
│       ├── cyber.md
│       ├── research.md
│       ├── memory.md
│       ├── report.md
│       └── devops.md
├── docs/                          # 文档输出目录
│   ├── prd.md
│   ├── architecture.md
│   ├── api-spec.md
│   ├── database.md
│   ├── project-plan.md
│   ├── review-report.md
│   ├── test-plan.md
│   └── test-report.md
├── src/                           # 后端源码
├── frontend/                      # 前端源码
├── tests/                         # 测试脚本
├── reports/                       # 生成的报告
└── deployment/                    # 部署配置
```

## License

[MIT License](LICENSE)

## 相关链接

- [opencode 官网](https://opencode.ai)
- [opencode 文档](https://opencode.ai/docs)
- [配置 Schema](https://opencode.ai/config.json)
- [GitHub 仓库](https://github.com/Ibuprovan/team_agents)
