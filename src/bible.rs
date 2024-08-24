use serde_json::{Map, Value};

const NT_TREE_JSON: &str = include_str!("bible.json");

pub fn get_content(book: &str, chapter: i32, verse: i32) -> Result<String, String> {
    let book = book.to_string();
    let chapter = chapter.to_string();
    let verse = verse.to_string();
    let data: Value = serde_json::from_str(NT_TREE_JSON).expect("It should be formatted properly");
    let tree: Map<String, Value> = data.as_object().expect("Should be a valid object").clone();
    match tree.get(&book) {
        Some(chapters) => match chapters.get(&chapter) {
            Some(verses) => match verses.get(&verse) {
                Some(content) => Ok(content.to_string()),
                None => Err(format!(
                    "'{} {}' has no verse '{}'.",
                    &book, &chapter, &verse
                )),
            },
            None => Err(format!("'{}' has no chapter '{}'.", &book, &chapter)),
        },
        None => Err(format!("'{book}' is not in the Bible.")),
    }
}
