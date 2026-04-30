function setup(config)
    config.ui.theme = { dark = "ember", light = "ember-light" }
    config.action("copy-to-clipboard", function()
        local checked_files = context.checked_files()
        if checked_files then
            local file_names = table.concat(checked_files, " ")
            copy_to_clipboard(file_names)
            flash("Copied checked files: " .. file_names)
            return
        end
        local selected_file = context.file()
        if selected_file then
            copy_to_clipboard(selected_file)
            flash("Copied file: " .. selected_file)
            return
        end
        local change_id = context.change_id()
        if change_id then
            copy_to_clipboard(change_id)
            flash("Copied change ID: " .. change_id)
            return
        end
        flash("No item selected to copy")
    end, { desc = "copy selection to clipboard" })

    config.bind({ action = "copy-to-clipboard", key = "Y", scope = "revisions", desc = "copy selection to clipboard" })
    config.bind({ action = "copy-to-clipboard", key = "Y", scope = "files", desc = "copy selection to clipboard" })

    config.action("quick-revset", function()
        local selected = choose({
            options = {
                "mine()",
                "all()",
                "trunk()..@",
                revset.default()
            },
            title = "Quick Revset"
        })

        if selected then
            revset.set(selected)
            flash("Revset: " .. selected)
        end
    end, {
        key = "alt+r",
        scope = "revisions",
        desc = "quick revset picker",
    })

    config.action("push-change", function()
        local change_id = context.change_id()
        jj("git", "push", "--change", change_id)
        revisions.refresh()
    end, {
        key = "C",
        scope = "revisions",
        desc = "git push current change",
    })
end
