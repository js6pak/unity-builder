import { getExecOutput, ExecOptions } from '@actions/exec';

export async function execWithErrorCheck(
  commandLine: string,
  arguments_?: string[],
  options?: ExecOptions,
): Promise<number> {
  const result = await getExecOutput(commandLine, arguments_, options);

  // Check for errors in the Build Results section
  const match = result.stdout.match(/^#\s*Build results\s*#(.*)^Size:/ms);

  if (match) {
    const buildResults = match[1];
    const errorMatch = buildResults.match(/^Errors:\s*(\d+)$/m);
    if (errorMatch) {
      const errors = Number.parseInt(errorMatch[1], 10);
      if (errors > 0) {
        console.warn(`There were ${errors} errors during the build. Please read the logs for details.`)
      }
    }
  }

  if (!result.stdout.includes("Build succeeded!")) {
    throw new Error(`There was an error building the project. Please read the logs for details.`);
  }

  console.log("Unity build finished successfully");
  return result.exitCode;
}
