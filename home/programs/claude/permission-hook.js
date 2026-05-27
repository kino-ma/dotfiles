#!/usr/bin/env osascript -l JavaScript

/* Setup AppleScript */
const app = Application.currentApplication();
app.includeStandardAdditions = true;

// Use FD 3 instead of stdin (fd 1) because AppleScript closes stdin
// See: https://stackoverflow.com/a/18732806
const stdinText = app.doShellScript('cat <&3');

/* Constants */
const HOOK_EVENT_NAME = "PermissionRequest";

const BUTTON_ALLOW = "Allow";
const BUTTON_ALWAYS_ALLOW = "Always Allow";
const BUTTON_DENY = "Decline";

const OUTPUT_ALLOW = "allow";
const OUTPUT_DENY = "deny";

/* Make decision according to pressed button */
const makeDecision = (buttonReturned) => {
  const decisionMapping = {
    [BUTTON_ALLOW]: {
      hookEventName: HOOK_EVENT_NAME,
      permissionDecision: OUTPUT_ALLOW,
    },
    [BUTTON_ALWAYS_ALLOW]: {
      hookEventName: HOOK_EVENT_NAME,
      permissionDecision: OUTPUT_ALLOW,
      allowAlways: true,
    },
    [BUTTON_DENY]: {
      hookEventName: HOOK_EVENT_NAME,
      permissionDecision: OUTPUT_DENY,
    },
  };

  return decisionMapping[buttonReturned] ?? decisionMapping[BUTTON_DENY];
}

/* Main function */
function main() {
  const data = JSON.parse(stdinText);
  const toolName = data.tool_name || "<Unknown Tool>";
  const toolInput = data.tool_input || {};

  const operationDetails = Object.entries(toolInput).map(([key, value]) => {
    const str = value.toString();
    const displayValue = str.length <= 300
      ? str
      : value.substring(0, 300) + '...';

    return `  [${key}]\n  ${displayValue}`;
  }).join('\n\n');

  const text = `Authorize "${toolName}" operation`;
  const message = `Operation: ${toolName}\n\n${operationDetails}`;
  const buttons = [BUTTON_DENY, BUTTON_ALWAYS_ALLOW, BUTTON_ALLOW];

  // Display macOS alert
  const response = app.displayAlert(text, {
    message,
    buttons,
    defaultButton: BUTTON_ALLOW,
    cancelButton: BUTTON_DENY,
    as: 'informational'
  });

  const decision = makeDecision(response.buttonReturned);

  const output = {
    hookSpecificOutput: decision,
  };

  // Send response
  console.log(JSON.stringify(output));
}

try {
  main()
} catch (e) {
  console.log(JSON.stringify({
    hookSpecificOutput: {
      hookEventName: "PermissionRequest",
      permissionDecision: "deny",
      permissionDecisionReason: `An error occured while prompting to user: ${e}`
    }
  }));
}
