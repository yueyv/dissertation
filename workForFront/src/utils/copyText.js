const clipboard = navigator.clipboard || {
  writeText: (text) => {
    let copyInput = document.createElement('input');
    copyInput.value = text;
    document.body.appendChild(copyInput);
    copyInput.select();
    document.execCommand('copy');
    document.body.removeChild(copyInput);
  }
}
const copyText = async (content) => {
    try {
      await clipboard.writeText(content);
      message.success(`已粘贴到剪切板,${content}`);
    } catch {
      message.warning(`粘贴失败,手动输入${content}`);
    }

};
export default  copyText