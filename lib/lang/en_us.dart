Map<String, String> get getLang {
	Map<String, String> lang = {};
	lang['title'] = 'Flashpaws';

  // page titles
  lang['settingsPage'] = 'Settings';
  lang['reviewPage'] = 'Review';
  lang['reviewCompletePage'] = 'Review Complete';
  lang['practicePage'] = 'Practice - \${0} Cards Practiced';
  lang['multichoicePage'] = 'MultiChoice Test';
  lang['multichoiceResultPage'] = 'MultiChoice Results';

  // generic
  lang['confirm'] = 'Confirm';
  lang['cancel'] = 'Cancel';
  lang['close'] = 'Close';
  lang['save'] = 'Save';
  lang['edit'] = 'Edit';
  lang['preview'] = 'Preview';
  lang['flashcard'] = 'Flashcard';
  lang['skip'] = 'Skip';
  lang['overwrite'] = 'Overwrite';
  lang['delete'] = 'Delete';

  // btns
  lang['btn_all_cards'] = 'All Cards';
  lang['btn_practice'] = 'Practice';
  lang['btn_review'] = 'Review';
  lang['btn_multitest'] = 'Multi-Choice';
  lang['btn_light_theme'] = 'Light Theme';
  lang['btn_dark_theme'] = 'Dark Theme';
  lang['btn_auto_theme'] = 'System Theme';
  lang['btn_theme_brightness_menu'] = 'Change Theme';
  lang['btn_theme_color_menu'] = 'Select Theme Color';
  lang['btn_export_json'] = 'Export Json';
  lang['btn_import_json'] = 'Import Json';
  lang['bnt_apply_to_all'] = 'Apply to all?';

  // tooltip
  lang['tooltip_create_card'] = 'Create card';

  // heading
  lang['header_create_new_card'] = 'Create New Card';
  lang['header_delete_card'] = 'Delete Flashcard';
  lang['header_exit_app'] = 'Exit ${lang['title']}';
  lang['header_settings_drawer'] = 'Flashpaws - \${0}';
  lang['header_finish_test'] = 'Finish Test?';
  lang['header_finish_review'] = 'Finish Review?';
  lang['header_confirm_modify_card'] = 'Confirm Modification?';
  lang['header_confirm_cancel_modify'] = 'Confirm Cancel?';
  lang['header_card_conflict_overwrite'] = 'Overwrite Flashcard Conflict?';
  lang['header_confirm_overwrite'] = 'Overwrite Existing Card?';

  // msg
  lang['msg_confirm_delete_card'] = 'The card \'\${0}\' will be deleted, continue?';
  lang['msg_confirm_app_exit'] = 'You are about to exit the app, continue?';
  lang['msg_finish_test'] = 'Are you sure you would like to finish this test?';
  lang['msg_finish_review'] = 'Are you sure you would like to finish this review?';
  lang['msg_confirm_modify_card'] = 'You are about to perminently change this card, are you sure you with continue?';
  lang['msg_confirm_cancel_modify'] = 'This card has been modified, confirming will erease these changes. Confirm?';
  lang['msg_card_conflict_overwrite'] = 'This conflicts with an existing flashcard. Would you like to overwrite the existing flashcard?';
  lang['msg_confirm_overwrite'] = 'The flashcard \'\${0}\' allready exists, do you want to overwrite it?';

  // texts
  lang['txt_review_stats'] = '## **STATS:**  \n### **Score:** \${0} / \${1} **Percent:** \${2}%';
  lang['txt_multichoice_stats'] = '## **TEST RESULTS:**  \n### **Points Scored:** \${0} / \${1} **Percent:** \${2}%';

  // hint
  lang['hint_create_new_card_key'] = 'Term/Question';
  lang['hint_create_new_card_deck'] = 'Deck (folder)';
  lang['hint_create_new_card_values'] = 'Correct Definition/Answer';
  lang['hint_create_new_card_values_fake'] = 'Fake Definition/Answer (optional)';
  lang['hint_create_new_card_tags'] = 'Tags (separated by [space])';

  // errors
  lang['err_hdr_create_empty_key'] = 'ERROR: Empty Key';
  lang['err_msg_create_empty_key'] = 'The term/question is empty. Please enter the term/question for this card.';
  lang['err_hdr_create_empty_values'] = 'ERROR: Empty Values';
  lang['err_msg_create_empty_values'] = 'The definition/answer is empty. Please enter the definition/answer for this card.';
  lang['err_hdr_create_duplicate_card'] = 'ERROR: Duplicate Card';
  lang['err_msg_create_duplicate_card'] = 'There is already a card in this deck with the same term/question. Please change the term/question of this card, or put it in a different deck.';

  // emojis
  lang['ico_check'] = '(✔️)';
  lang['ico_cross'] = '(❌)';
  lang['ico_mark'] = '(❕)';

  //intro cards
  lang['introcard_how_to_new_card'] = 'How to create a new card.';
  lang['introcard_how_to_new_card_answer'] = '''
To make a new card, press the '+' button on the bottom right of the screen. Enter the information, and
Tada!!!
'''.trim();
  lang['introcard_how_to_sort_cards'] = 'How to sort cards.';
  lang['introcard_how_to_sort_cards_answer'] = '''
Cards are sorted similar to folders on your computer. These 'folders' are represented by the second
row of buttons. Selecting one of these buttons will update the displayed contents to show the cards
and folders that are nested under the selected folder. To go back a folder, you can simply press the
folder you want to view from. And if you want to clear the filter, you can press the 'All Cards'
button.
'''.trim();
  lang['introcard_how_to_practice'] = 'How to practice flashcards.';
  lang['introcard_how_to_practice_answer'] = '''
The practice mode buttons are viewable at the top of the display. The 'Flashcard' mode will go
through all the cards matched by the current filter. The card will only show the key until flipped
revealing the value. You will also be givin a way to mark how well you remembered the information on
the card. The 'Infinite' mode will continously cycle through the matched cards the same way that
'Flashcards' does, except with no end, and no way to mark the level of understanding. 'Multi-Choice'
provides a multiple choice test for the matched cards.
'''.trim();

	return lang;
}