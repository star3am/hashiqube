(function () {
    // 下面是解析的部分
    const chatMap = {
        "&": "&amp;",
        "'": "&#x27;",
        "`": "&#x60;",
        '"': "&quot;",
        "<": "&lt;",
        ">": "&gt;",
    };
    const escapeHTML = (string) => {
        if (typeof string !== "string") return string;
        return string.replace(/[&'`"<>]/g, function (match) {
            return chatMap[match];
        });
    };
    window.drawioConverter = function (xml, idx = new Date().getTime()) {
        let mxGraphData = {
            editable: false,
            highlight: "#0000ff",
            nav: false,
            toolbar: null,
            edit: null,
            resize: true,
            lightbox: "open",
            // "check-visible-state": false,
            // "auto-fit": false,
            // move: false,
            xml,
        };

        const json = JSON.stringify(mxGraphData);

        return `<div class="drawio-viewer-index-${idx}">
          <div class="mxgraph" style="max-width: 100%; border: 1px solid transparent" data-mxgraph="${escapeHTML(json)}"></div>
        </div>
        `;
    };

    // 下面是插件加载部分

    const install = function (hook) {
        hook.doneEach((hook) => {
            try {
                window.GraphViewer.processElements();
            } catch {}
        });
    };

    window.$docsify.plugins = [].concat(install, $docsify.plugins);
})();
