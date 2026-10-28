(function PinkWowTheme() {
    const SCHEMES = {
        "Dynamic-Album": {
            name: "Warna Album (Dinamis)",
            desc: "Otomatis mengikuti warna cover album musik yang sedang diputar",
            colors: {
                "text": "121212",
                "subtext": "334155",
                "main": "ffe500",
                "main-elevated": "fff066",
                "highlight": "fef08a",
                "highlight-elevated": "fde047",
                "sidebar": "86efac",
                "player": "93c5fd",
                "card": "ffffff",
                "shadow": "121212",
                "selected-row": "fed7aa",
                "button": "ff4338",
                "button-active": "e02424",
                "button-disabled": "94a3b8",
                "tab-active": "ff4338",
                "notification": "fb923c",
                "notification-error": "ef4444",
                "misc": "121212"
            }
        },
        "Neo-Multicolor": {
            name: "Neo-Multicolor (Asli)",
            desc: "Kombinasi Kuning, Hijau, Biru, Merah & Oren",
            colors: {
                "text": "121212",
                "subtext": "334155",
                "main": "ffe500",
                "main-elevated": "fff066",
                "highlight": "fef08a",
                "highlight-elevated": "fde047",
                "sidebar": "86efac",
                "player": "93c5fd",
                "card": "ffffff",
                "shadow": "121212",
                "selected-row": "fed7aa",
                "button": "ff4338",
                "button-active": "e02424",
                "button-disabled": "94a3b8",
                "tab-active": "ff4338",
                "notification": "fb923c",
                "notification-error": "ef4444",
                "misc": "121212"
            }
        },
        "Neo-Yellow": {
            name: "Neo-Yellow",
            desc: "Kuning Gumroad & Aksen Merah",
            colors: {
                "text": "121212",
                "subtext": "374151",
                "main": "ffe500",
                "main-elevated": "ffd700",
                "highlight": "fff59d",
                "highlight-elevated": "fff176",
                "sidebar": "fff176",
                "player": "fff59d",
                "card": "ffffff",
                "shadow": "121212",
                "selected-row": "fff9c4",
                "button": "ff3b30",
                "button-active": "e0281e",
                "button-disabled": "9e9e9e",
                "tab-active": "ff3b30",
                "notification": "ff3b30",
                "notification-error": "d32f2f",
                "misc": "121212"
            }
        },
        "Neo-Blue": {
            name: "Neo-Blue",
            desc: "Biru Elektrik & Aksen Merah",
            colors: {
                "text": "121212",
                "subtext": "1e293b",
                "main": "60a5fa",
                "main-elevated": "3b82f6",
                "highlight": "bfdbfe",
                "highlight-elevated": "93c5fd",
                "sidebar": "bae6fd",
                "player": "93c5fd",
                "card": "ffffff",
                "shadow": "121212",
                "selected-row": "dbeafe",
                "button": "ff4338",
                "button-active": "dc2626",
                "button-disabled": "64748b",
                "tab-active": "ff4338",
                "notification": "ffe600",
                "notification-error": "ef4444",
                "misc": "121212"
            }
        },
        "Neo-Green": {
            name: "Neo-Green",
            desc: "Hijau Mint / Lime & Aksen Merah",
            colors: {
                "text": "121212",
                "subtext": "14532d",
                "main": "86efac",
                "main-elevated": "4ade80",
                "highlight": "bbf7d0",
                "highlight-elevated": "86efac",
                "sidebar": "bbf7d0",
                "player": "dcfce7",
                "card": "ffffff",
                "shadow": "121212",
                "selected-row": "d1fae5",
                "button": "ff4338",
                "button-active": "dc2626",
                "button-disabled": "6b7280",
                "tab-active": "ff4338",
                "notification": "ff4338",
                "notification-error": "b91c1c",
                "misc": "121212"
            }
        },
        "Neo-Orange": {
            name: "Neo-Orange",
            desc: "Oren Pop & Aksen Biru",
            colors: {
                "text": "121212",
                "subtext": "431407",
                "main": "fb923c",
                "main-elevated": "f97316",
                "highlight": "fed7aa",
                "highlight-elevated": "fb923c",
                "sidebar": "fed7aa",
                "player": "ffedd5",
                "card": "ffffff",
                "shadow": "121212",
                "selected-row": "ffedd5",
                "button": "2563eb",
                "button-active": "1d4ed8",
                "button-disabled": "78716c",
                "tab-active": "2563eb",
                "notification": "2563eb",
                "notification-error": "dc2626",
                "misc": "121212"
            }
        },
        "Neo-Red": {
            name: "Neo-Red",
            desc: "Merah Pop Retro & Aksen Biru",
            colors: {
                "text": "121212",
                "subtext": "4c0519",
                "main": "fb7185",
                "main-elevated": "f43f5e",
                "highlight": "fecdd3",
                "highlight-elevated": "fb7185",
                "sidebar": "fecdd3",
                "player": "ffe4e6",
                "card": "ffffff",
                "shadow": "121212",
                "selected-row": "ffe4e6",
                "button": "2563eb",
                "button-active": "1d4ed8",
                "button-disabled": "71717a",
                "tab-active": "2563eb",
                "notification": "ffe600",
                "notification-error": "991b1b",
                "misc": "121212"
            }
        },
        "Pink": {
            name: "Pink (Original)",
            desc: "Warna Pink Asli PinkWow",
            colors: {
                "text": "1e1414",
                "subtext": "593b39",
                "main": "e8beb9",
                "main-elevated": "f2d1cd",
                "highlight": "fce2df",
                "highlight-elevated": "f7c5be",
                "sidebar": "deb2ac",
                "player": "f2d1cd",
                "card": "f5d6d3",
                "shadow": "1e1414",
                "selected-row": "f7b2aa",
                "button": "ff6b5b",
                "button-active": "ff4f3d",
                "button-disabled": "7a524f",
                "tab-active": "ff6b5b",
                "notification": "ff6b5b",
                "notification-error": "e63946",
                "misc": "1e1414"
            }
        }
    };

    function hexToRgb(hex) {
        if (hex.startsWith("#")) hex = hex.slice(1);
        if (hex.length === 3) hex = hex.split('').map(c => c + c).join('');
        const num = parseInt(hex, 16);
        return `${(num >> 16) & 255},${(num >> 8) & 255},${num & 255}`;
    }

    function hexToHsl(hex) {
        if (hex.startsWith('#')) hex = hex.slice(1);
        if (hex.length === 3) hex = hex.split('').map(c => c + c).join('');
        const r = parseInt(hex.substring(0, 2), 16) / 255;
        const g = parseInt(hex.substring(2, 4), 16) / 255;
        const b = parseInt(hex.substring(4, 6), 16) / 255;
        const max = Math.max(r, g, b), min = Math.min(r, g, b);
        let h, s, l = (max + min) / 2;
        if (max === min) {
            h = s = 0;
        } else {
            const d = max - min;
            s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
            switch (max) {
                case r: h = (g - b) / d + (g < b ? 6 : 0); break;
                case g: h = (b - r) / d + 2; break;
                case b: h = (r - g) / d + 4; break;
            }
            h /= 6;
        }
        return [Math.round(h * 360), Math.round(s * 100), Math.round(l * 100)];
    }

    function hslToHex(h, s, l) {
        h = (h % 360 + 360) % 360;
        s = Math.max(0, Math.min(100, s)) / 100;
        l = Math.max(0, Math.min(100, l)) / 100;
        const a = s * Math.min(l, 1 - l);
        const f = n => {
            const k = (n + h / 30) % 12;
            const color = l - a * Math.max(Math.min(k - 3, 9 - k, 1), -1);
            return Math.round(255 * color).toString(16).padStart(2, '0');
        };
        return `${f(0)}${f(8)}${f(4)}`;
    }

    function resolveImageUrl(raw) {
        if (!raw || typeof raw !== "string") return null;
        if (raw.startsWith("http://") || raw.startsWith("https://") || raw.startsWith("blob:") || raw.startsWith("data:")) {
            return raw;
        }
        const cleanId = raw.replace(/^spotify:image:/i, "").split(":").pop();
        if (cleanId && cleanId.length > 5) {
            return "https://i.scdn.co/image/" + cleanId;
        }
        return null;
    }

    function getTrackImageUrl() {
        // 1. Check DOM image directly (most reliable because Spotify ALREADY loaded it!)
        const domImg = document.querySelector(".main-nowPlayingWidget-coverArt img") ||
                       document.querySelector(".main-nowPlayingWidget-nowPlaying img") ||
                       document.querySelector("img[data-testid='cover-art-image']") ||
                       document.querySelector(".main-coverSlotCollapsed-container img") ||
                       document.querySelector(".main-coverSlotExpanded-container img") ||
                       document.querySelector(".Root__now-playing-bar img");
        if (domImg && domImg.src && (domImg.src.startsWith("http") || domImg.src.startsWith("blob:"))) {
            return domImg.src;
        }

        // 2. Check Spicetify.Player.data.item.metadata
        const track = window.Spicetify?.Player?.data?.item;
        if (track?.metadata) {
            const meta = track.metadata;
            const candidate = meta.image_xlarge_url || meta.image_large_url || meta.image_url || meta.image_small_url || meta.album_cover || meta.cover_art_url;
            const resolved = resolveImageUrl(candidate);
            if (resolved) return resolved;
        }

        // 3. Check track.album.images
        if (track?.album?.images?.length) {
            const resolved = resolveImageUrl(track.album.images[0].url);
            if (resolved) return resolved;
        }

        return null;
    }

    function samplePaletteFromPixels(pixels) {
        const buckets = Array.from({ length: 12 }, () => ({
            hSum: 0, sSum: 0, lSum: 0, count: 0, score: 0, maxSat: 0, vibrantHsl: null
        }));

        let colorfulCount = 0;

        for (let i = 0; i < pixels.length; i += 4) {
            const r = pixels[i], g = pixels[i + 1], b = pixels[i + 2], a = pixels[i + 3];
            if (a < 128) continue;

            const [h, s, l] = hexToHsl(((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1));

            // Exclude extreme darks and extreme brights without color
            if (l < 10 || (l > 92 && s < 15)) continue;

            if (s < 12) continue; // Skip near grayscale pixels

            colorfulCount++;
            const bucketIdx = Math.floor((h % 360) / 30);
            const bObj = buckets[bucketIdx];
            const weight = (s / 100) * (1 - Math.abs(l - 50) / 50);

            bObj.hSum += h;
            bObj.sSum += s;
            bObj.lSum += l;
            bObj.count++;
            bObj.score += weight;

            if (s > bObj.maxSat) {
                bObj.maxSat = s;
                bObj.vibrantHsl = [h, s, l];
            }
        }

        // Grayscale / Black & White album fallback
        if (colorfulCount === 0) {
            return { baseHsl: [210, 10, 50], vibrantHsl: [210, 80, 48] };
        }

        // Find dominant colorful bucket
        let bestBucket = buckets[0];
        for (const b of buckets) {
            if (b.score > bestBucket.score) {
                bestBucket = b;
            }
        }

        const avgH = Math.round(bestBucket.hSum / bestBucket.count);
        const avgS = Math.round(bestBucket.sSum / bestBucket.count);
        const avgL = Math.round(bestBucket.lSum / bestBucket.count);

        return {
            baseHsl: [avgH, avgS, avgL],
            vibrantHsl: bestBucket.vibrantHsl || [avgH, avgS, avgL]
        };
    }

    async function extractPaletteFromUrl(imageUrl) {
        if (!imageUrl) return null;
        try {
            let blobUrl = imageUrl;
            let shouldRevoke = false;

            // If it's a remote URL, fetch as blob to completely bypass Chromium CORS cache tainting
            if (imageUrl.startsWith("http://") || imageUrl.startsWith("https://")) {
                try {
                    const res = await fetch(imageUrl);
                    if (res.ok) {
                        const blob = await res.blob();
                        blobUrl = URL.createObjectURL(blob);
                        shouldRevoke = true;
                    }
                } catch (fetchErr) {
                    console.debug("[PinkWow] Blob fetch failed, trying direct img:", fetchErr);
                }
            }

            const img = new Image();
            img.crossOrigin = "anonymous";

            await new Promise((resolve, reject) => {
                img.onload = () => resolve(true);
                img.onerror = (e) => reject(e);
                const cleanUrl = blobUrl.includes("?") ? blobUrl + "&_cb=" + Date.now() : blobUrl + "?_cb=" + Date.now();
                img.src = shouldRevoke ? blobUrl : cleanUrl;
            });

            const canvas = document.createElement("canvas");
            canvas.width = 32;
            canvas.height = 32;
            const ctx = canvas.getContext("2d", { willReadFrequently: true });
            ctx.drawImage(img, 0, 0, 32, 32);

            if (shouldRevoke) {
                URL.revokeObjectURL(blobUrl);
            }

            const imgData = ctx.getImageData(0, 0, 32, 32).data;
            return samplePaletteFromPixels(imgData);
        } catch (err) {
            console.debug("[PinkWow] extractPaletteFromUrl failed:", err);
            return null;
        }
    }

    function generateNeobrutalismPalette(paletteData) {
        const baseHsl = paletteData?.baseHsl || [350, 40, 80];
        const vibrantHsl = paletteData?.vibrantHsl || baseHsl;

        const [h, s, l] = baseHsl;
        // In Neobrutalism, background is light and crisp with high contrast against #121212 text
        const bgS = Math.min(Math.max(s, 25), 65);
        const mainBg = hslToHex(h, bgS, 82);
        const mainElevated = hslToHex(h, bgS + 5, 87);
        const sidebarBg = hslToHex((h + 20) % 360, Math.min(bgS, 50), 85);
        const playerBg = hslToHex((h - 20 + 360) % 360, Math.min(bgS, 50), 88);
        const highlight = hslToHex(h, Math.min(bgS + 10, 75), 78);
        const highlightElevated = hslToHex(h, Math.min(bgS + 15, 80), 73);
        const selectedRow = hslToHex(h, Math.min(bgS, 55), 86);

        // High impact action button
        const btnH = vibrantHsl[0];
        const btnS = Math.max(75, vibrantHsl[1]);
        const btnL = Math.max(40, Math.min(50, vibrantHsl[2]));
        const button = hslToHex(btnH, btnS, btnL);
        const buttonActive = hslToHex(btnH, btnS, btnL - 10);
        const buttonDisabled = hslToHex(h, 15, 65);

        return {
            "text": "121212",
            "subtext": "2d3748",
            "main": mainBg,
            "main-elevated": mainElevated,
            "highlight": highlight,
            "highlight-elevated": highlightElevated,
            "sidebar": sidebarBg,
            "player": playerBg,
            "card": "ffffff",
            "shadow": "121212",
            "selected-row": selectedRow,
            "button": button,
            "button-active": buttonActive,
            "button-disabled": buttonDisabled,
            "tab-active": button,
            "notification": button,
            "notification-error": "ef4444",
            "misc": "121212"
        };
    }

    function applyCssVariables(colors) {
        let style = document.getElementById("pinkwow-dynamic-scheme");
        if (!style) {
            style = document.createElement("style");
            style.id = "pinkwow-dynamic-scheme";
            document.head.appendChild(style);
        }

        let css = ":root {\n";
        for (const [key, val] of Object.entries(colors)) {
            css += `  --spice-${key}: #${val} !important;\n`;
            css += `  --spice-rgb-${key}: ${hexToRgb(val)} !important;\n`;
        }
        css += "}\n";
        style.innerHTML = css;
    }

    function updateDropdownLabel(text) {
        const currentText = document.getElementById("pinkwow-current-scheme-text");
        if (currentText) {
            currentText.textContent = text;
        }
    }

    let lastTrackUri = null;

    async function updateDynamicAlbumColors(notify = false) {
        if (localStorage.getItem("pinkwow:active-scheme") !== "Dynamic-Album") return;

        const track = window.Spicetify?.Player?.data?.item;
        const imgUrl = getTrackImageUrl();

        if (!imgUrl && !track) {
            applyCssVariables(SCHEMES["Dynamic-Album"].colors);
            updateDropdownLabel("Warna Album (Dinamis)");
            return;
        }

        const uri = track?.uri || imgUrl;
        lastTrackUri = uri;

        let colors = null;

        // 1. Try direct DOM sampling first (instant if loaded and not tainted)
        const domImg = document.querySelector(".main-nowPlayingWidget-coverArt img") ||
                       document.querySelector(".main-nowPlayingWidget-nowPlaying img") ||
                       document.querySelector("img[data-testid='cover-art-image']") ||
                       document.querySelector(".main-coverSlotCollapsed-container img");
        if (domImg && domImg.complete && domImg.naturalWidth > 0) {
            try {
                const c = document.createElement("canvas");
                c.width = 32; c.height = 32;
                const ctx = c.getContext("2d", { willReadFrequently: true });
                ctx.drawImage(domImg, 0, 0, 32, 32);
                const data = ctx.getImageData(0, 0, 32, 32).data;
                const paletteData = samplePaletteFromPixels(data);
                if (paletteData) {
                    colors = generateNeobrutalismPalette(paletteData);
                }
            } catch (e) {
                // Tainted canvas, fall through to fetch
            }
        }

        // 2. Extract palette using high-precision pixel sampling
        if (!colors && imgUrl) {
            const paletteData = await extractPaletteFromUrl(imgUrl);
            if (paletteData) {
                colors = generateNeobrutalismPalette(paletteData);
            }
        }

        // Fallback to Spicetify.colorExtractor if canvas wasn't available
        if (!colors && window.Spicetify?.colorExtractor && track?.uri && !track.isLocal) {
            try {
                const swatches = await Spicetify.colorExtractor(track.uri);
                if (swatches) {
                    const primary = swatches.VIBRANT || swatches.LIGHT_VIBRANT || swatches.PROMINENT;
                    if (primary) {
                        const [h, s, l] = hexToHsl(primary.replace("#", ""));
                        colors = generateNeobrutalismPalette({ baseHsl: [h, s, l], vibrantHsl: [h, s, l] });
                    }
                }
            } catch (e) {
                console.debug("[PinkWow] colorExtractor fallback failed:", e);
            }
        }

        if (!colors) {
            colors = SCHEMES["Dynamic-Album"].colors;
        }

        applyCssVariables(colors);
        updateDropdownLabel("Warna Album (Dinamis)");

        if (notify && window.Spicetify?.showNotification) {
            const title = track?.metadata?.title || "Lagu";
            Spicetify.showNotification(`Warna Album: ${title}`);
        }
    }

    function applyScheme(schemeKey, notify = true) {
        if (schemeKey === "Dynamic-Album") {
            localStorage.setItem("pinkwow:active-scheme", "Dynamic-Album");
            updateDropdownLabel(SCHEMES["Dynamic-Album"].name);
            updateDynamicAlbumColors(notify);
            return;
        }

        const scheme = SCHEMES[schemeKey];
        if (!scheme) return;

        localStorage.setItem("pinkwow:active-scheme", schemeKey);
        applyCssVariables(scheme.colors);
        updateDropdownLabel(scheme.name);

        if (notify && window.Spicetify && Spicetify.showNotification) {
            Spicetify.showNotification(`Skema warna: ${scheme.name}`);
        }
    }

    let songChangeAttached = false;
    function setupSongChangeListener() {
        if (songChangeAttached) return;
        if (window.Spicetify?.Player?.addEventListener) {
            songChangeAttached = true;
            // Immediate update + delayed retry to catch updated artwork
            const handleSongChange = () => {
                if (localStorage.getItem("pinkwow:active-scheme") === "Dynamic-Album") {
                    setTimeout(() => updateDynamicAlbumColors(false), 150);
                    setTimeout(() => updateDynamicAlbumColors(false), 600);
                }
            };
            Spicetify.Player.addEventListener("songchange", handleSongChange);
            Spicetify.Player.addEventListener("onplaypause", handleSongChange);
        }
    }

    function syncMarketplace() {
        try {
            const rawSchemes = {};
            for (const [key, val] of Object.entries(SCHEMES)) {
                rawSchemes[key] = val.colors;
            }
            const active = localStorage.getItem("pinkwow:active-scheme") || "Neo-Multicolor";
            const manifest = {
                name: "PinkWow",
                user: "Custom",
                repo: "PinkWow",
                branch: "main",
                main: "user.css",
                description: "Authentic Neobrutalism theme with vibrant color options",
                schemes: rawSchemes,
                activeScheme: active
            };
            localStorage.setItem("marketplace:installed:theme:PinkWow", JSON.stringify(manifest));
            const installed = JSON.parse(localStorage.getItem("marketplace:installed-themes") || "[]");
            if (!installed.includes("marketplace:installed:theme:PinkWow")) {
                installed.push("marketplace:installed:theme:PinkWow");
                localStorage.setItem("marketplace:installed-themes", JSON.stringify(installed));
            }
        } catch (e) {
            console.debug("[PinkWow] Marketplace sync error:", e);
        }
    }

    function mountDropdown() {
        const contentRight = document.querySelector(".main-globalNav-contentRight");
        if (!contentRight) return;

        if (contentRight.querySelector("#pinkwow-scheme-container")) return;

        const oldContainers = document.querySelectorAll("#pinkwow-scheme-container");
        oldContainers.forEach(el => el.remove());

        const container = document.createElement("div");
        container.id = "pinkwow-scheme-container";
        container.style.cssText = "position: relative; display: inline-flex; align-items: center; z-index: 1000; margin-right: 8px; -webkit-app-region: no-drag !important;";

        const currentActive = localStorage.getItem("pinkwow:active-scheme") || "Neo-Multicolor";
        const currentScheme = SCHEMES[currentActive] || SCHEMES["Neo-Multicolor"];

        const btn = document.createElement("button");
        btn.id = "pinkwow-scheme-btn";
        btn.type = "button";
        btn.setAttribute("aria-haspopup", "true");
        btn.setAttribute("aria-expanded", "false");
        btn.innerHTML = `
            <span id="pinkwow-current-scheme-text">${currentScheme.name}</span>
            <svg viewBox="0 0 16 16" width="12" height="12" fill="currentColor" style="margin-left: 6px; flex-shrink: 0;">
                <path d="M3 6l5 5 5-5H3z"/>
            </svg>
        `;

        const menu = document.createElement("div");
        menu.id = "pinkwow-scheme-menu";
        menu.style.display = "none";

        for (const [key, val] of Object.entries(SCHEMES)) {
            const item = document.createElement("div");
            item.className = "pinkwow-menu-item" + (key === currentActive ? " active" : "");
            item.dataset.scheme = key;
            item.innerHTML = `
                <span>${val.name}</span>
                <span class="pinkwow-check" style="font-size: 11px; margin-left: 8px;">${key === currentActive ? "✓" : ""}</span>
            `;
            item.addEventListener("click", (e) => {
                e.stopPropagation();
                applyScheme(key, true);
                syncMarketplace();

                updateDropdownLabel(val.name);

                menu.querySelectorAll(".pinkwow-menu-item").forEach(el => {
                    const isActive = el.dataset.scheme === key;
                    el.classList.toggle("active", isActive);
                    const check = el.querySelector(".pinkwow-check");
                    if (check) check.textContent = isActive ? "✓" : "";
                });

                menu.style.display = "none";
                btn.setAttribute("aria-expanded", "false");
            });
            menu.appendChild(item);
        }

        btn.addEventListener("click", (e) => {
            e.stopPropagation();
            const isOpen = menu.style.display === "flex";
            menu.style.display = isOpen ? "none" : "flex";
            btn.setAttribute("aria-expanded", isOpen ? "false" : "true");
        });

        document.addEventListener("click", (e) => {
            if (!container.contains(e.target)) {
                menu.style.display = "none";
                btn.setAttribute("aria-expanded", "false");
            }
        });

        container.appendChild(btn);
        container.appendChild(menu);

        contentRight.insertBefore(container, contentRight.firstChild);
    }

    // Apply saved scheme immediately on launch
    const initialScheme = localStorage.getItem("pinkwow:active-scheme") || "Neo-Multicolor";
    applyScheme(initialScheme, false);
    syncMarketplace();

    // Hook song change listener
    setupSongChangeListener();
    const playerWait = setInterval(() => {
        if (window.Spicetify?.Player?.addEventListener) {
            setupSongChangeListener();
            if (localStorage.getItem("pinkwow:active-scheme") === "Dynamic-Album") {
                updateDynamicAlbumColors(false);
            }
            clearInterval(playerWait);
        }
    }, 400);

    // Polling until contentRight exists
    let attempts = 0;
    const checkInterval = setInterval(() => {
        mountDropdown();
        attempts++;
        const contentRight = document.querySelector(".main-globalNav-contentRight");
        if ((contentRight && contentRight.querySelector("#pinkwow-scheme-container")) || attempts > 25) {
            clearInterval(checkInterval);
        }
    }, 400);

    // Observer for SPA route changes
    const observer = new MutationObserver(() => {
        const contentRight = document.querySelector(".main-globalNav-contentRight");
        if (contentRight && !contentRight.querySelector("#pinkwow-scheme-container")) {
            mountDropdown();
        }
    });
    observer.observe(document.body, { childList: true, subtree: true });
})();
