import { application } from "../application"

import SearchController from "./search_controller";
application.register("search", SearchController);
import MarkdownController from "./markdown_controller";
application.register("markdown", MarkdownController);
import HelpSearchController from "./help_search_controller";
application.register("help-search", HelpSearchController);
import SnippetController from "./snippet_controller";
application.register("snippet", SnippetController);
import ChatController from "./chat_controller";
application.register("chat", ChatController);
import CharacterCountController from "./character_count_controller";
application.register("character-count", CharacterCountController);
import SidebarController from "./sidebar_controller";
application.register("sidebar", SidebarController);

import { RailsuiClipboard, RailsuiCountUp, RailsuiCombobox, RailsuiDateRangePicker, RailsuiDropdown, RailsuiModal, RailsuiRange, RailsuiReadMore,RailsuiSelectAll, RailsuiTabs, RailsuiToast, RailsuiToggle, RailsuiTooltip } from 'railsui-stimulus'

application.register('railsui-clipboard', RailsuiClipboard)
application.register('railsui-count-up', RailsuiCountUp)
application.register('railsui-combobox', RailsuiCombobox)
application.register('railsui-date-range-picker', RailsuiDateRangePicker)
application.register('railsui-dropdown', RailsuiDropdown)
application.register('railsui-modal', RailsuiModal)
application.register('railsui-range', RailsuiRange)
application.register('railsui-read-more', RailsuiReadMore)
application.register('railsui-select-all', RailsuiSelectAll)
application.register('railsui-tabs', RailsuiTabs)
application.register('railsui-toast', RailsuiToast)
application.register('railsui-toggle', RailsuiToggle)
application.register('railsui-tooltip', RailsuiTooltip)
