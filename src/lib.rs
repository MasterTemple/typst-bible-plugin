use wasm_macro::*;
mod bible;

initiate_protocol!();

macro_rules! str {
    ($val: expr, $type: expr) => {
        match String::from_utf8($val.to_vec()) {
            Ok(val) => val,
            Err(_) => return Err(format!("{}: Failed to parse '' as UTF-8 string.", $type)),
        }
    };
}

macro_rules! int {
    ($val: expr, $type: expr) => {
        match str!($val, $type).parse::<i32>() {
            Ok(val) => val,
            Err(_) => {
                return Err(format!(
                    "{}: '{}' is not a valid integer.",
                    $type,
                    str!($val, $type)
                ))
            }
        }
    };
}

macro_rules! bytes {
    ($val: expr) => {
        $val.as_bytes().to_vec()
    };
}

macro_rules! ok {
    ($val: expr) => {
        Ok(bytes!($val))
    };
}

#[wasm_func]
pub fn get_verse(
    book: &[u8],
    chapter: &[u8],
    verse: &[u8],
    translation: &[u8],
) -> Result<Vec<u8>, String> {
    let book = str!(book, "Book");
    let chapter = int!(chapter, "Chapter");
    let verse = int!(verse, "Verse");
    let _translation = str!(translation, "Translation");
    let content = bible::get_content(&book, chapter, verse)?;
    ok!(content)
}
