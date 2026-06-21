import { writeFileSync, mkdirSync, existsSync, readFileSync } from "fs";
import { join } from "path";

export const PmoAuditPlugin = async ({ client, $, directory, worktree }) => {
  const workDir = worktree || directory;
  const auditDir = join(workDir, ".opencode");
  const auditFile = join(auditDir, "pmo-audit.json");

  if (!existsSync(auditDir)) mkdirSync(auditDir, { recursive: true });
  if (!existsSync(auditFile)) writeFileSync(auditFile, "[]");

  return {
    "tool.execute.after": async (input, output) => {
      if (input.tool === "task") {
        const current = JSON.parse(readFileSync(auditFile, "utf8"));
        current.push({
          t: new Date().toISOString(),
          subagent: input.args?.subagent_type || input.args?.agent || "unknown",
          desc: (input.args?.description || "").slice(0, 100),
          prompt: (input.args?.prompt || "").slice(0, 200),
          ok: !output.error,
          error: output.error ? String(output.error).slice(0, 200) : null,
        });
        writeFileSync(auditFile, JSON.stringify(current, null, 2));
        await client.app.log({
          body: {
            service: "pmo-audit",
            level: "info",
            message: `task->${input.args?.subagent_type || input.args?.agent || "?"}`,
            extra: { ok: !output.error },
          },
        });
      }
    },
  };
};
