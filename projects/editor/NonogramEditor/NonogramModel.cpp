#include "NonogramModel.h"

#include <iostream>

NonogramModel::NonogramModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

NonogramModel::~NonogramModel()
{
}

int NonogramModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent); // or (void)parent;
    return m_cells.size();
}

QVariant NonogramModel::data(const QModelIndex &index, int role) const
{
    if (role == IsColored) {
        return m_cells[index.row()];
    }
    return QVariant();
}

QHash<int, QByteArray> NonogramModel::roleNames() const
{
    QHash<int, QByteArray> ret;
    ret[IsColored] = "isColored";
    return ret;
}

QString NonogramModel::name() const
{
    return m_name;
}

void NonogramModel::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

QString NonogramModel::comment() const
{
    return m_comment;
}

void NonogramModel::setComment(const QString &comment)
{
    if (m_comment != comment) {
        m_comment = comment;
        emit commentChanged();
    }
}

int NonogramModel::width() const
{
    return m_width;
}

int NonogramModel::height() const
{
    return m_height;
}

QJsonObject NonogramModel::toJsonObject() const
{
    QJsonObject json;
    json.insert("name", m_name);
    json.insert("comment", m_comment);
    json.insert("width", m_width);
    json.insert("height", m_height);
    json.insert("cells", QJsonValue(cellsToJsonArray()));
    return json;
}

void NonogramModel::setSize(int width, int height)
{
    m_width = width;
    m_height = height;

    m_cells.clear();
    // 1 - painted cell; 0 - not painted cell
    for (int i = 0; i < m_width * m_height; ++i) {
        m_cells.push_back(0);
    }
    emit layoutChanged();
}

void NonogramModel::initWithJsonObject(const QJsonObject &jsonObject)
{
    m_name = jsonObject["name"].toString();
    emit nameChanged();

    m_comment = jsonObject["comment"].toString();
    emit commentChanged();

    m_width = jsonObject["width"].toInt();
    m_height = jsonObject["height"].toInt();

    initCells(jsonObject["cells"].toArray());
    emit layoutChanged();
}

void NonogramModel::toggleCell(int index)
{
    int value = m_cells[index];
    m_cells[index] = (value == 0) ? 1 : 0;
    emit layoutChanged();
}

QJsonArray NonogramModel::cellsToJsonArray() const
{
    QJsonArray arr;
    for (int i = 0; i != m_cells.size(); ++i) {
        arr.push_back(QJsonValue(m_cells[i]));
    }
    return arr;
}

void NonogramModel::initCells(const QJsonArray &cells)
{
    m_cells.clear();
    for (int i = 0; i < cells.size(); ++i) {
        m_cells.push_back(cells[i].toInt());
    }
}
