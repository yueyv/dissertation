const useAvatarIndex = (username) => {
  const code = username[username.length - 1].charCodeAt();
  const index = code % 12;
  return index === 0 ? 12 : index;
};

export default useAvatarIndex;
