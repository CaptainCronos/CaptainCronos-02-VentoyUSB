# Captain Cronos Ventoy USB

Standardized Ventoy rescue, recovery, diagnostics, and deployment USB structure.

## Purpose

This repository tracks the layout, configuration, documentation, scripts, and theme assets for the Captain Cronos Ventoy USB.

Large ISO files, extracted vendor driver payloads, and other large deployment binaries are **not** intended to be committed directly to GitHub. The repository documents the structure that should exist on the physical Ventoy USB; the actual payloads live on the USB and may also be retained locally on the Linux workstation.

## Main Areas

- `ISO/Linux`
- `ISO/Windows`
- `ISO/Utilities`
- `Tools`
- `theme`
- `config`
- `docs`
- `scripts`

## Dell Latitude 5420 Rugged - Windows 11

The Ventoy USB will also carry the Dell Latitude 5420 Rugged Windows 11 driver/audit payload.

The development repository for the audit tooling is:

```text
CaptainCronos/5420-Rugged-Win11
```

The current Dell baseline is:

```text
Latitude 5420 Rugged DRIVER PACK A00
Driver ID: 6MXM3
Windows 11 x64
Latitude-5420-Rugged-6MXM3_Win11_1.0_A00.exe
```

The Dell executable and extracted driver payload are intentionally **not stored in GitHub**. They belong on the physical USB and, when useful, in the local Linux download/work directory.

### USB layout

Use a model-specific directory with shared Dell payload/tooling and Service-Tag-specific audit results:

```text
Drivers/
`-- Dell/
    `-- Latitude-5420-Rugged/
        `-- Win11/
            `-- 6MXM3-A00/
                |-- Audit-DellDriverBundle.ps1
                |-- Manifest.xml
                |-- <extracted Dell driver payload>
                `-- Audit-Results/
                    `-- XXXXX/
                        `-- <TIMESTAMP>/
                            |-- Summary.txt
                            |-- System-Information.csv
                            |-- Current-Devices.csv
                            |-- Current-Drivers.csv
                            |-- DriverStore.csv
                            |-- Problem-Devices.csv
                            |-- Bundle-Releases.csv
                            |-- Bundle-INF-Files.csv
                            `-- Bundle-Hardware-Matches.csv
```

`XXXXX` is a **placeholder for the Dell Service Tag**, not a literal fleet directory name. `Audit-DellDriverBundle.ps1` reads the Service Tag from BIOS and automatically creates:

```text
Audit-Results\<SERVICE-TAG>\<TIMESTAMP>\
```

This allows one Ventoy USB to audit multiple Latitude 5420 Rugged systems without mixing machine-specific results.

### Driver audit workflow

1. Extract `Latitude-5420-Rugged-6MXM3_Win11_1.0_A00.exe` into the `6MXM3-A00` directory on the physical USB.
2. Copy the current `Audit-DellDriverBundle.ps1` from `CaptainCronos/5420-Rugged-Win11` into the root of that extracted bundle.
3. On the target Latitude 5420 Rugged, open PowerShell 7 as Administrator.
4. Change to the `6MXM3-A00` directory on the USB.
5. If necessary, temporarily allow script execution:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

6. Run:

```powershell
.\Audit-DellDriverBundle.ps1
```

7. Retain the **entire generated Service Tag/timestamp directory** for analysis.

The audit is read-only. It inventories the actual machine, current Windows driver bindings, Windows Driver Store, Dell `Manifest.xml`, and the extracted Dell INF files. It does not install, remove, stage, replace, upgrade, or downgrade drivers.

### Information retained per system

The generated audit data includes:

- Dell model, Service Tag, BIOS, UUID, and Windows build information.
- PnP devices, hardware IDs, and compatible IDs.
- Current published OEM INF and driver binding information.
- Driver provider, version, date, and signer.
- Windows Driver Store inventory and original INF information where available.
- PnP problem devices.
- Dell manifest ReleaseID/category/device metadata.
- Extracted Dell INF metadata.
- Correlation between actual hardware and matching Dell driver candidates.

The detailed comparison logic and future selective installer are maintained in `CaptainCronos/5420-Rugged-Win11`; this repository documents how that tooling and its large driver payload fit onto the physical Ventoy USB.
