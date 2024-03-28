const copyText = async (content) => {
    try {
      await navigator.clipboard.writeText(content);
      message.success(`已粘贴到剪切板,${content}`);
    } catch {
      message.warning(`粘贴失败,手动输入${content}`);
    }

};
export default  copyText