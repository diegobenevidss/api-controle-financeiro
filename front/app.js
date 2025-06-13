let token = null;

function login() {
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;

  fetch("http://localhost:4000/api/login", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ email, password })
  })
    .then(res => res.json())
    .then(data => {
      token = data.token;
      document.getElementById("tokenDisplay").textContent = token;
    })
    .catch(() => alert("Erro no login"));
}

function registerUser() {
  const name = document.getElementById("cad_name").value;
  const email = document.getElementById("cad_email").value;
  const password = document.getElementById("cad_password").value;

  fetch("http://localhost:4000/api/users", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name, email, password })
  })
    .then(res => {
      if (!res.ok) throw res;
      return res.json();
    })
    .then(() => alert("Usuário cadastrado com sucesso!"))
    .catch(async (err) => {
      const msg = await err.json();
      alert("Erro ao cadastrar usuário:\n" + JSON.stringify(msg.errors));
    });
}

function getUsers() {
  fetch("http://localhost:4000/api/users", {
    method: "GET",
    headers: { "Authorization": "Bearer " + token }
  })
    .then(res => res.json())
    .then(data => {
      document.getElementById("usersDisplay").textContent = JSON.stringify(data, null, 2);
    })
    .catch(() => alert("Erro ao buscar usuários"));
}

function createTransaction() {
  const description = document.getElementById("trans_description").value;
  const amount = parseFloat(document.getElementById("trans_amount").value);
  const type = document.getElementById("trans_type").value;
  const date = document.getElementById("trans_date").value + ":00Z";
  const user_id = document.getElementById("trans_user_id").value;

  fetch("http://localhost:4000/api/transactions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    },
    body: JSON.stringify({
      transaction: { description, amount, type, date, user_id }
    })
  })
    .then(res => {
      if (!res.ok) throw res;
      return res.json();
    })
    .then(() => alert("Transação cadastrada!"))
    .catch(async (err) => {
      const msg = await err.json().catch(() => ({ error: 'Erro inesperado' }));
      alert("Erro ao cadastrar transação:\n" + JSON.stringify(msg));
    });
}

function getTransactions() {
  fetch("http://localhost:4000/api/transactions", {
    method: "GET",
    headers: {
      "Authorization": "Bearer " + token
    }
  })
    .then(res => res.json())
    .then(data => {
      document.getElementById("transactionsDisplay").textContent = JSON.stringify(data, null, 2);
    })
    .catch(() => alert("Erro ao buscar transações"));
}

function createTag() {
  const name = document.getElementById("tag_name").value;
  const user_id = document.getElementById("tag_user_id").value;

  const tagData = {
    tag: {
      name,
      user_id
    }
  };

  fetch("http://localhost:4000/api/tags", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(tagData)
  })
    .then(res => {
      if (!res.ok) throw res;
      return res.json();
    })
    .then(data => {
      alert("Tag cadastrada com sucesso!");
    })
    .catch(async (err) => {
      const msg = await err.json().catch(() => ({ error: 'Erro inesperado' }));
      alert("Erro ao cadastrar tag:\n" + JSON.stringify(msg));
    });
}




function getTags() {
  fetch("http://localhost:4000/api/tags", {
    method: "GET",
    headers: {
      "Authorization": "Bearer " + token
    }
  })
    .then(res => res.json())
    .then(data => {
      document.getElementById("tagsDisplay").textContent = JSON.stringify(data, null, 2);
    })
    .catch(() => alert("Erro ao buscar tags"));
}
