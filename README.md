# **Phoenix LiveView AI Filters POC**

An AI-powered, natural language search input built with **Phoenix LiveView**, **OpenAI**, and **Ecto**. This proof-of-concept demonstrates how to dynamically generate filters from user queries and apply them in real-time without requiring users to manually configure search filters.

## 🎥 **Demo**

Watch the demo video: **[Demo Link](https://www.awesomescreenshot.com/video/36903860?key=5dca7faccf4cdef5db3d1c5fdca39908)**.

## ⚙️ **Configuration**

Before starting the app, set up the **OpenAI API key** in `config/dev.exs`:

```elixir
# OpenAI
config :openai,
  api_key: YOUR_OPENAI_API_KEY
```

### **OpenAI Setup**

To enable AI-powered search filtering, set up an OpenAI account and obtain an API key:

1. Sign up at [OpenAI](https://openai.com)
2. Retrieve your **API Key** from the OpenAI dashboard
3. Replace `YOUR_OPENAI_API_KEY` in `config/dev.exs` with your actual key

---

## 🚀 **Getting Started**

Follow these steps to set up and run the application:

### **1️⃣ Clone the Repository**

```sh
git clone <repository-url>
cd phoenix_liveview_ai_filters_poc
```

### **2️⃣ Set Up Configuration**

Modify `config/dev.exs` with your OpenAI API credentials.

### **3️⃣ Install Dependencies**

```sh
mix deps.get
```

### **4️⃣ Set Up the Database**

```sh
mix ecto.create
mix ecto.migrate
```

### **5️⃣ Start the Application**

```sh
iex -S mix phx.server
```

Open your browser and visit: **http://localhost:4000/projects**

## 🧪 **Running Tests**

To run the test suite, execute the following command:

```sh
mix test
```

## ✨ **Features**

👉 **Natural Language Search** – Users type queries naturally, and AI converts them into structured filters.
👉 **Real-Time Updates** – **Phoenix LiveView** ensures search results update instantly without reloading the page.
👉 **AI-Powered Filtering** – **OpenAI GPT-4** translates user queries into **Ecto-compatible filters**.
👉 **Multi-Language Support** – AI understands and processes queries in multiple languages.
👉 **Scalable & Flexible** – The search system can be expanded to support additional data sources.

## 📝 **License**

This project is licensed under the **MIT License**. See the [LICENSE](./LICENSE) file for more details.
