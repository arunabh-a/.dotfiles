import Adw from 'gi://Adw';
import GLib from 'gi://GLib';
import GObject from 'gi://GObject';
import Gdk from 'gi://Gdk';
import Gio from 'gi://Gio';
import { bindPref, getPref, setPref } from '../../utils/settings.js';
import { EditShadowPage } from '../widgets/edit_shadow_page.js';
import { ResetPage } from '../widgets/reset_page.js';
import '../widgets/paddings_row.js';
export const General = GObject.registerClass({
    Template: GLib.uri_resolve_relative(import.meta.url, 'general.ui', GLib.UriFlags.NONE),
    GTypeName: 'PrefsGeneral',
    InternalChildren: [
        'skip_libadwaita',
        'skip_libhandy',
        'border_width',
        'border_color',
        'corner_radius',
        'corner_smoothing',
        'keep_for_maximized',
        'keep_for_fullscreen',
        'paddings',
        'tweak_kitty',
        'right_click_menu',
        'enable_log',
    ],
}, class extends Adw.PreferencesPage {
    constructor() {
        super();
        this._cfg = getPref('global-rounded-corner-settings');
        bindPref('skip-libadwaita-app', this._skip_libadwaita, 'active', Gio.SettingsBindFlags.DEFAULT);
        bindPref('skip-libhandy-app', this._skip_libhandy, 'active', Gio.SettingsBindFlags.DEFAULT);
        bindPref('border-width', this._border_width, 'value', Gio.SettingsBindFlags.DEFAULT);
        const color = new Gdk.RGBA();
        [color.red, color.green, color.blue, color.alpha] =
            getPref('border-color');
        this._border_color.set_rgba(color);
        this._border_color.connect('notify::rgba', (btn) => {
            const color = btn.get_rgba();
            setPref('border-color', [
                color.red,
                color.green,
                color.blue,
                color.alpha,
            ]);
        });
        this._corner_radius.set_value(this._cfg.borderRadius);
        this._corner_radius.connect('value-changed', (adj) => {
            this._cfg.borderRadius = adj.get_value();
            this._update_global_config();
        });
        this._corner_smoothing.set_value(this._cfg.smoothing);
        this._corner_smoothing.connect('value-changed', (adj) => {
            this._cfg.smoothing = adj.get_value();
            this._update_global_config();
        });
        this._keep_for_maximized.set_active(this._cfg.keepRoundedCorners.maximized);
        this._keep_for_maximized.connect('notify::active', (swtch) => {
            this._cfg.keepRoundedCorners.maximized = swtch.get_active();
            this._update_global_config();
        });
        this._keep_for_fullscreen.set_active(this._cfg.keepRoundedCorners.fullscreen);
        this._keep_for_fullscreen.connect('notify::active', (swtch) => {
            this._cfg.keepRoundedCorners.fullscreen =
                swtch.get_active();
            this._update_global_config();
        });
        this._paddings.paddingTop = this._cfg.padding.top;
        this._paddings.connect('notify::padding-top', (row) => {
            this._cfg.padding.top = row.paddingTop;
            this._update_global_config();
        });
        this._paddings.paddingBottom = this._cfg.padding.bottom;
        this._paddings.connect('notify::padding-bottom', (row) => {
            this._cfg.padding.bottom = row.paddingBottom;
            this._update_global_config();
        });
        this._paddings.paddingStart = this._cfg.padding.left;
        this._paddings.connect('notify::padding-start', (row) => {
            this._cfg.padding.left = row.paddingStart;
            this._update_global_config();
        });
        this._paddings.paddingEnd = this._cfg.padding.right;
        this._paddings.connect('notify::padding-end', (row) => {
            this._cfg.padding.right = row.paddingEnd;
            this._update_global_config();
        });
        bindPref('tweak-kitty-terminal', this._tweak_kitty, 'active', Gio.SettingsBindFlags.DEFAULT);
        bindPref('enable-preferences-entry', this._right_click_menu, 'active', Gio.SettingsBindFlags.DEFAULT);
        bindPref('debug-mode', this._enable_log, 'active', Gio.SettingsBindFlags.DEFAULT);
    }
    show_reset_page(_) {
        const root = this.root;
        root.push_subpage(new ResetPage());
    }
    show_shadow_page(_) {
        const root = this.root;
        root.push_subpage(new EditShadowPage());
    }
    _update_global_config() {
        setPref('global-rounded-corner-settings', this._cfg);
    }
});
