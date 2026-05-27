#!/usr/bin/env osascript -l JavaScript

const app = Application.currentApplication();
app.includeStandardAdditions = true;

// fd 3 から JSON を読み込む
const stdinText = app.doShellScript('cat <&3');

try {
  const jsonData = JSON.parse(stdinText);
  const toolName = jsonData.tool_name || 'Unknown Tool';
  const toolInput = jsonData.tool_input || {};

  // 操作情報をテキスト化
  let operationDetails = '';
  const inputKeys = Object.keys(toolInput);
  if (inputKeys.length > 0) {
    operationDetails = inputKeys.map(key => {
      const value = toolInput[key];
      let displayValue;
      if (typeof value === 'string') {
        if (value.length > 100) {
          displayValue = value.substring(0, 100) + '...';
        } else {
          displayValue = value;
        }
      } else {
        displayValue = JSON.stringify(value);
      }
      return `  [${key}]\n  ${displayValue}`;
    }).join('\n\n');
  }

  const messageText = `Operation: ${toolName}\n\n${operationDetails}`;

  // アラート表示（3つのボタン、ボタン順序：Deny（左）、Allow Always（中央）、Allow（右））
  const response = app.displayAlert(`Authorize "${toolName}" operation`, {
    message: messageText,
    buttons: ['Deny', 'Allow Always', 'Allow'],
    defaultButton: 'Allow',
    cancelButton: 'Deny',
    as: 'informational'
  });

  let decision = 'deny';
  if (response.buttonReturned === 'Allow') {
    decision = 'allow';
  } else if (response.buttonReturned === 'Allow Always') {
    decision = 'allow';
  }

  const output = {
    hookSpecificOutput: {
      hookEventName: 'PermissionRequest',
      permissionDecision: decision
    }
  };

  // "Allow Always" の場合は追加情報を含める
  if (response.buttonReturned === 'Allow Always') {
    output.hookSpecificOutput.allowAlways = true;
  }

  console.log(JSON.stringify(output));
} catch (e) {
  // エラーまたはキャンセルの場合は deny
  console.log(JSON.stringify({
    hookSpecificOutput: {
      hookEventName: 'PermissionRequest',
      permissionDecision: 'deny'
    }
  }));
}
