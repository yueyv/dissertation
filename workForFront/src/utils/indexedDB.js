// 打开或创建数据库
const openRequest = indexedDB.open('chatDatabase', 1);

openRequest.onupgradeneeded = (event) => {
  const db = event.target.result;
  
  // 创建对象存储空间
  const chatStore = db.createObjectStore('chats', { keyPath: 'id', autoIncrement: true });
};

openRequest.onsuccess = (event) => {
  const db = event.target.result;
  
  // 添加数据
  const transaction = db.transaction(['chats'], 'readwrite');
  const chatStore = transaction.objectStore('chats');
  
  const chatRecord = {
    sender: 'userA',
    receiver: 'userB',
    message: 'Hello, world!',
    timestamp: new Date().getTime()
  };

  const addRequest = chatStore.add(chatRecord);
  
  addRequest.onsuccess = () => {
    console.log('Chat record added successfully');
  };

  addRequest.onerror = () => {
    console.error('Failed to add chat record');
  };
};
