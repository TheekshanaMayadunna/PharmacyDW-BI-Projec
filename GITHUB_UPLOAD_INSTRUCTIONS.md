# 🚀 How to Push This Project to GitHub

## One-Time Setup (if Git not installed)

Download Git from https://git-scm.com/downloads and install it.

---

## Step 1 — Create a GitHub Repository

1. Go to https://github.com and sign in
2. Click **"New"** (green button, top left)
3. Fill in:
   - **Repository name:** `PharmacyDW-BI-Project`
   - **Description:** `Data Warehousing & BI project — SLIIT IT3021`
   - **Visibility:** Public or Private (your choice)
   - ❌ Do NOT tick "Add README" (we already have one)
4. Click **"Create repository"**
5. Copy the URL shown — looks like:
   `https://github.com/YOUR_USERNAME/PharmacyDW-BI-Project.git`

---

## Step 2 — Copy Your SSIS / SSAS / Power BI Files

Before pushing, manually copy your actual project files into the folders:

```
ssis-packages/    ← paste your .dtsx files here
ssas/             ← paste your entire SSAS Visual Studio project folder here
powerbi/          ← paste your .pbix file here
docs/assignment1/ ← paste IT23584068.pdf here
docs/assignment2/ ← paste IT23584068_Assignement_02.pdf here
data/source-files/ ← paste your CSV, Excel, TXT source files here
```

---

## Step 3 — Open Terminal / Command Prompt

Navigate to your project folder:

```bash
cd path\to\PharmacyDW_BI_Project
```

Example on Windows:
```bash
cd C:\Users\YourName\Desktop\PharmacyDW_BI_Project
```

---

## Step 4 — Initialize Git and Push

Run these commands one by one:

```bash
# Initialize git repo
git init

# Add all files
git add .

# First commit
git commit -m "Initial commit: PharmacyDW BI project — SLIIT IT23584068"

# Connect to your GitHub repo (replace URL with yours)
git remote add origin https://github.com/YOUR_USERNAME/PharmacyDW-BI-Project.git

# Push to GitHub
git branch -M main
git push -u origin main
```

---

## Step 5 — Verify on GitHub

Go to `https://github.com/YOUR_USERNAME/PharmacyDW-BI-Project`  
You should see all your files and the README displayed on the page.

---

## Future Updates

Whenever you make changes:

```bash
git add .
git commit -m "Describe what you changed"
git push
```

---

## Tips

- If your CSV is large (>50MB), use [Git LFS](https://git-lfs.github.com/):
  ```bash
  git lfs install
  git lfs track "*.csv"
  git add .gitattributes
  ```
- Use **GitHub Desktop** (https://desktop.github.com/) if you prefer a visual interface instead of the terminal
