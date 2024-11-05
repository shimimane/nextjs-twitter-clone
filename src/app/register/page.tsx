'use client';

import { useState } from 'react';
import axios from 'axios';

export default function Register() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await axios.post('/api/register', { name, email, password });
      alert('登録成功');
    } catch (error) {
      console.error(error);
      alert('登録失敗');
    }
  };

  return (
    <div className="container">
      <h2>ユーザー登録</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label className="form-label">名前</label>
          <input type="text" className="form-control" value={name} onChange={(e) => setName(e.target.value)} required />
        </div>
        <div className="mb-3">
          <label className="form-label">メールアドレス</label>
          <input type="email" className="form-control" value={email} onChange={(e) => setEmail(e.target.value)} required />
        </div>
        <div className="mb-3">
          <label className="form-label">パスワード</label>
          <input type="password" className="form-control" value={password} onChange={(e) => setPassword(e.target.value)} required />
        </div>
        <button type="submit" className="btn btn-primary">登録</button>
      </form>
    </div>
  );
}
