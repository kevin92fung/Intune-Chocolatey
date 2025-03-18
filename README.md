### **Information**  

This script makes it possible to deploy applications using Chocolatey packages. The script runs in two steps: first, it checks if Chocolatey needs to be installed or updated, and then it installs the package.  

The same prepared file is reusable, and the package to be installed is chosen from the install command.  

To use this script, you first need to prepare it for Intune.  
Follow this guide to prepare the file: [Microsoft-Win32-Content-Prep-Tool](https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool).  

---

### **Intune**  

1. **Create a new Windows App**, and select **Windows app (Win32)**.  
2. Select the prepared file.  

#### **App Information:**  
- Update the **name** to match the package name.  
- Add a **description**.  
- Add a **publisher**.  

#### **Program:**  
- **Install command:**  
  ```powershell
  powershell.exe -ExecutionPolicy Bypass -File .\install.ps1 <package>
  ```  
- **Uninstall command:**  
  ```powershell
  powershell.exe -ExecutionPolicy Bypass -File .\install.ps1 <package>
  ```  
Find available packages here: [Chocolatey Community Packages](https://community.chocolatey.org/packages).  

---

### **Requirements:**  
- Select **64-bit or 32-bit**, depending on the OS where the app will be installed.  
- Select the **minimum operating system** required to run the app.  

---

### **Detection Rules:**  
1. Select **"Use a custom detection script"**.  
2. Modify the detection script listed in this repository to match the package name with the selected package for installation.  
