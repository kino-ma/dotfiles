#!/usr/bin/env osascript -l JavaScript

/* Setup AppleScript */
const app = Application.currentApplication();
app.includeStandardAdditions = true;

// This brings `$` variable into the scope
ObjC.import("Foundation");

// Use FD 3 instead of stdin (fd 1) because AppleScript closes stdin
// See: https://stackoverflow.com/a/18732806
const stdinText = app.doShellScript('cat <&3');

/* Constants */
const HOOK_EVENT_NAME = "PermissionRequest";

const BUTTON_ALLOW = "Allow";
const BUTTON_ALWAYS_ALLOW = "Always Allow";
const BUTTON_DENY = "Cancel";

const OUTPUT_ALLOW = "allow";
const OUTPUT_DENY = "deny";

/* Format a permission suggestion entry for display */
const DESTINATION_LABELS = {
  session: 'This session',
  localSettings: 'Local',
  projectSettings: 'Project',
  userSettings: 'User global',
};

const formatSuggestion = (s) => {
  const dest = DESTINATION_LABELS[s.destination] ?? s.destination;
  const formatRules = (label) =>
    s.rules.map(r => `  ${label} (${dest}): ${r.ruleContent ? `${r.toolName}(${r.ruleContent})` : r.toolName}`).join('\n');
  const formatDirectories = (label) =>
    s.directories.map(d => `  ${label} (${dest}): ${d}`).join('\n');
  switch (s.type) {
    case 'addRules':
      return formatRules('Add rules');
    case 'replaceRules':
      return formatRules('Replace rules');
    case 'removeRules':
      return formatRules('Remove rules');
    case 'setMode':
      return `  Set mode (${dest}): ${s.mode}`;
    case 'addDirectories':
      return formatDirectories('Add directories');
    case 'removeDirectories':
      return formatDirectories('Remove directories');
    default:
      return `  ${JSON.stringify(s)}`;
  }
};

/* Format a Bash command for display.
 * `;` separates commands onto their own line; `|`, `&&`, `||` move the
 * operator to the start of an following line. */
const formatBashCommand = (command) => {
  const tokens = command.split(/(\s*(?:&&|\|\||;|\|)\s*)/);
  return tokens.map((token, i) => {
    // Even indices are command segments, odd indices are separators.
    if (i % 2 === 0) { return token.trim(); }
    const op = token.trim();

    // macOS alerts remove leading whitespaces of each line.
    // Instead of indenting the entire line, insert a '\t' after operators.
    return op === ';' ? ';\n\n' : `\n${op}\t`;
  }).join('');
};

/* Make decision according to pressed button */
const makeDecision = (buttonReturned, suggestions) => {
  if (buttonReturned === BUTTON_ALWAYS_ALLOW) {
    return {
      hookEventName: HOOK_EVENT_NAME,
      decision: { behavior: OUTPUT_ALLOW, updatedPermissions: suggestions },
    };
  } else if (buttonReturned === BUTTON_ALLOW) {
    return {
      hookEventName: HOOK_EVENT_NAME,
      decision: { behavior: OUTPUT_ALLOW },
    };
  } else {
    return {
      hookEventName: HOOK_EVENT_NAME,
      decision: { behavior: OUTPUT_DENY },
    };
  }
}

/* Main function */
function main() {
  const data = JSON.parse(stdinText);
  const toolName = data.tool_name || "<Unknown Tool>";
  const toolInput = data.tool_input || {};

  // In IntelliJ, the bundled diff view handles Edit approvals, so skip the
  // alert and only notify, deferring the decision to the built-in UI.
  const environment = $.NSProcessInfo.processInfo.environment.js;
  const terminalEmulator = 'TERMINAL_EMULATOR' in environment
    ? environment.TERMINAL_EMULATOR.js
    : undefined;
  const isIntelliJ = terminalEmulator === 'JetBrains-JediTerm';
  if (isIntelliJ && toolName === 'Edit') {
    app.displayNotification(`Authorize "${toolName}" operation`, {
      withTitle: "Claude",
      soundName: "alert",
    });
    return;
  }

  const operationDetails = Object.entries(toolInput).map(([key, value]) => {
    const str = toolName === 'Bash' && key === 'command'
      ? formatBashCommand(value.toString())
      : value.toString();
    const displayValue = str.length <= 300
      ? str
      : str.substring(0, 300) + '...';

    return `  [${key}]\n  ${displayValue}`;
  }).join('\n\n');

  const suggestions = data.permission_suggestions ?? [];
  const formattedSuggestions = suggestions.map(formatSuggestion).join('\n');
  const suggestionsText = suggestions.length > 0
    ? `\n\nAlways Allow will add:\n${formattedSuggestions}`
    : '';

  const text = `Authorize "${toolName}" operation`;
  const message = `Operation: ${toolName}\n\n${operationDetails}${suggestionsText}`;
  const buttons = suggestions.length > 0
    ? [BUTTON_DENY, BUTTON_ALWAYS_ALLOW, BUTTON_ALLOW]
    : [BUTTON_DENY, BUTTON_ALLOW];

  // Display macOS alert (cancelButton throws errorNumber -128)
  // See: https://bru6.de/jxa/basics/interacting-with-users/
  let response;
  try {
    app.displayNotification(text, {
      withTitle: "Claude",
      soundName: "alert",
    });

    delay(0.4);

    response = app.displayAlert(text, {
      message,
      buttons,
      defaultButton: BUTTON_ALLOW,
      cancelButton: BUTTON_DENY,
      as: 'informational'
    });
  } catch (e) {
    if (e.errorNumber === -128) { return; }
    throw e;
  }

  const decision = makeDecision(response.buttonReturned, suggestions);

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
      reason: `An error occured while prompting to user: ${e}`
    }
  }));
}
