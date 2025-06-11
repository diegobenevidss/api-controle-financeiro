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
    .catch(err => alert("Erro no login"));
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
    .catch(err => alert("Erro ao buscar usuários"));
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
    .then(res => res.json())
    .then(data => {
      alert("Usuário cadastrado com sucesso!");
      console.log("Usuário:", data);
    })
    .catch(err => alert("Erro ao cadastrar usuário"));
}

