# Tasks Runtime

`docs/tasks/` is the file bus for real agent-to-agent collaboration.

## Rules

1. PMO is the only role allowed to orchestrate the full workflow.
2. Any claim that another agent has worked on a task must correspond to a real subagent invocation.
3. Every handoff must be written to a task file before the next agent starts.
4. Downstream agents must read files from disk instead of relying on chat-only summaries.

## Task Types

- `FEATURE`: new work, enhancements, iterative optimization
- `DEBUG`: defect triage, root-cause analysis, regression fix
- `ARCH`: architecture adjustment, refactor, technical arbitration
- `RESEARCH`: research, benchmarking, security analysis

## Required Lifecycle

`TODO -> IN_PROGRESS -> REVIEWS -> TESTING -> DONE`

Fallback states:

- `REJECTED`: send back with concrete reason and missing acceptance criteria
- `BLOCKED`: PMO arbitration after more than 3 rejected round-trips

## Required Sections

Every task file must contain:

1. Basic info: status, owner, priority, type
2. Request summary
3. Input dependencies
4. Expected outputs
5. Acceptance criteria
6. Handoff notes for the next agent
7. Flow history

## Dispatch Contract

When PMO dispatches a specialist, the specialist prompt must include:

1. The task file path
2. The files to read first
3. The files to write or update
4. The condition for completion
5. The next expected workflow state
