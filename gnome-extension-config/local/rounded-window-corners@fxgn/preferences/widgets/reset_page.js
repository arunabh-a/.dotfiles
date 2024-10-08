import Adw from 'gi://Adw';
import GLib from 'gi://GLib';
import GObject from 'gi://GObject';
import { gettext as _ } from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js';
import { logDebug } from '../../utils/log.js';
import { getPref, prefs, setPref } from '../../utils/settings.js';
class Cfg {
    description;
    reset = false;
    constructor(description) {
        this.description = description;
    }
}
export const ResetPage = GObject.registerClass({
    Template: GLib.uri_resolve_relative(import.meta.url, 'reset-page.ui', GLib.UriFlags.NONE),
    GTypeName: 'ResetPage',
    InternalChildren: ['reset_grp', 'reset_btn', 'dialog'],
}, class extends Adw.NavigationPage {
    constructor() {
        super();
        this._rows = [];
        this._init_cfg();
        this._build_ui();
    }
    _init_cfg() {
        this._reset_keys = {
            'skip-libadwaita-app': new Cfg(_('Skip LibAdwaita Applications')),
            'skip-libhandy-app': new Cfg(_('Skip LibHandy Applications')),
            'focused-shadow': new Cfg(_('Focus Window Shadow Style')),
            'unfocused-shadow': new Cfg(_('Unfocus Window Shadow Style')),
            'border-width': new Cfg(_('Border Width')),
            'border-color': new Cfg(_('Border Color')),
            'debug-mode': new Cfg(_('Enable Log')),
        };
        this._reset_corners_cfg = {
            borderRadius: new Cfg(_('Border Radius')),
            padding: new Cfg(_('Padding')),
            keepRoundedCorners: new Cfg(_('Keep Rounded Corners when Maximized or Fullscreen')),
            smoothing: new Cfg(_('Corner Smoothing')),
        };
    }
    _build_ui() {
        const build = (cfg) => {
            for (const key in cfg) {
                const row = new Adw.SwitchRow({
                    active: false,
                    name: key,
                });
                row.set_title(cfg[key].description);
                row.connect('notify::active', source => this.on_toggled(source));
                this._reset_grp.add(row);
                this._rows.push(row);
            }
        };
        build(this._reset_corners_cfg);
        build(this._reset_keys);
    }
    on_toggled(source) {
        const k = source.name;
        let v = this._reset_corners_cfg[k];
        if (v !== undefined) {
            v.reset = source.active;
            return;
        }
        v = this._reset_keys[k];
        if (v !== undefined) {
            v.reset = source.active;
            return;
        }
    }
    select_all() {
        for (const row of this._rows) {
            row.set_active(true);
        }
    }
    ask_for_reset() {
        // typescript thinks, that there should be 0-2 arguments, but actually
        // it will throw an error, if any of three argument is missing
        // @ts-ignore
        this._dialog.choose(this, null, null);
    }
    reset(_, response) {
        if (response === 'cancel') {
            return;
        }
        for (const k in this._reset_keys) {
            if (this._reset_keys[k]?.reset === true) {
                prefs.reset(k);
                logDebug(`Reset ${k}`);
            }
        }
        const key = 'global-rounded-corner-settings';
        const default_cfg = prefs
            .get_default_value(key)
            ?.recursiveUnpack();
        const current_cfg = getPref('global-rounded-corner-settings');
        for (const k in this._reset_corners_cfg) {
            const _k = k;
            if (this._reset_corners_cfg[_k]?.reset === true) {
                current_cfg[_k] = default_cfg[_k];
                logDebug(`Reset ${k}`);
            }
        }
        setPref('global-rounded-corner-settings', current_cfg);
        const root = this.root;
        root.pop_subpage();
    }
});
